# Please copy/paste all three classes into this file to submit your solution!
class Category

  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_or_create(category_string) ########
    Category.all.find do |category_instance|
      binding.pry
      if category_instance.name == category_string
        return category_instance
      else
        return Category.new(category_string)
      end
    end
  end

  def self.top_category
    hash = Hash.new
    Category.all.each do |category_instance|
      if hash[category_instance.name]
        hash[category_instance.name] += 1
      else
        hash[category_instance.name] = 1
      end
    end
    sorted = hash.max_by {|key, value| value}
    sorted[0]
  end

end


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

require 'pry'
require 'json'

# In terminal, you should be able to call Adapter.new('newyorker.json').create_objects_from_file and get the created Article objects as a return value

class Adapter
  attr_accessor :file, :articles

  def initialize(file)
    @file = file
    @articles = self.class.articles(file)
  end

  def self.articles(file)
    JSON.parse(File.read(file))
  end

  def create_objects_from_file
    @articles.each do |article_hash|
      contributor = article_hash["contributor"]
      title = article_hash["title"]
      description = article_hash["description"]
      url = article_hash["url"]
      publishedAt = article_hash["publishedAt"]
      category = article_hash["category"]
      Article.new(title, description, url, contributor, publishedAt, category)
      Category.new(category)
    end
    Article.all
  end

end
