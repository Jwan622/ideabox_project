class Idea
  include Comparable

  attr_reader :title, :description, :rank, :id, :tag, :time

  def initialize(attributes)
    @title = attributes['title']
    @description = attributes['description']
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
    @tag = attributes["tag"]
    @time = attributes["time"]

  end

  def formatted_time
    time.strftime("%A, %b %d %I:%M")
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank
    }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end

end
