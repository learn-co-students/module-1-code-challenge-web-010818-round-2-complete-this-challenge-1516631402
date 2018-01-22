class Article

  attr_accessor :title, :description, :url, :contributor, :publishedAt, :category
  @@all = []

  def initialize(title, description, url, contributor, publishedAt, category)
    @title = title
    @description = description
    @url = url
    @contributor = contributor
    @publishedAt = publishedAt
    @category = category
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_all_by_category(category)
    Article.all.select do |article_instance|
      if article_instance.category == category
        article_instance
      end
    end
  end

end
