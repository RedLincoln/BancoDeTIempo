class CreateCategories
  attr_accessor :name, :supcategory, :category

  def initialize(name: '', supcategory: '')
    @name = name
    @supcategory = supcategory
  end

  def build
    self.category = Category.new(name: @name, supcategory: @supcategory )
  end
end