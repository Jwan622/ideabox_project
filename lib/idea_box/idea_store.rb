require 'yaml/store'

class IdeaStore
  def self.database
    return @database if @database

    @database = YAML::Store.new('db/ideabox')
    @database.transaction do
      @database['ideas'] ||= []
    end
    @database
  end

  def self.all   #this adds ids to the hash of data, and creates Idea objects with the updated hash. raw_ideas is an array of hashes. 
    ideas = []
    raw_ideas.each_with_index do |data, i|
      ideas << Idea.new(data.merge("id" => i))
    end
    ideas
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.delete(position)   #this is called from the delete route in app.rb
    database.transaction do   #term in databases that you're doing something to it
      database['ideas'].delete_at(position)
    end
  end

  def self.find(id)   #creates an Idea object using a raw_idea hash.
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea.merge("id" => id))
  end

  def self.find_raw_idea(id)   #gets a hash from database using index of the hash
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def self.create(data, time) #data here is just a hash, the value of idea
    database.transaction do
      database['ideas'] << data.merge({"time" => time})
    end
  end

end
