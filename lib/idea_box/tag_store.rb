class TagStore
  def self.all
    IdeaStore.all.map{|idea| idea.tag}.uniq
  end

  def self.ideas_for(tag)
    IdeaStore.all.select{|idea| idea.tag == tag}
  end
end
