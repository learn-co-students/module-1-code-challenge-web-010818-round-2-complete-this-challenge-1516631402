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
