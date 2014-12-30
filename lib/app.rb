require 'idea_box/idea'
require 'idea_box/tag_store'
require 'idea_box/idea_store'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do   #IdeaStore.all is an array is an array of idea objects, we sort them on rank with .sort
    all_ideas = IdeaStore.all.sort

    erb :index, locals: {
      ideas: all_ideas,
      idea: Idea.new(params),
      tags: TagStore.all
    }   #what is params here?

  end

  post '/' do
    IdeaStore.create(params[:idea], Time.now)   #params[:idea] will be a an array with the keys as whatever is in the bracket within input/name= in the view.
                                      #params is a nested hash. the key is the first part of input/name in the view.
    redirect '/'
  end

  delete '/:id' do |x|
    IdeaStore.delete(x.to_i)
    binding.pry
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  get '/:tag/tags' do |tag|
    erb :tag_view, locals: {tag: tag, ideas: TagStore.ideas_for(tag)}
  end

end
