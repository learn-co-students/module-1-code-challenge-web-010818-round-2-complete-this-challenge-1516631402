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
