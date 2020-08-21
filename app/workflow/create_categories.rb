class CreateCategories
  attr_accessor :name, :supcategory, :success, :category

  def initialize(name: '', supcategory: '')
    @name = name
    @supcategory = supcategory
    @success = false
  end

  def build
    self.category = Category.new(name: @name, supcategory: @supcategory )
  end

  def create
    build
    @success = category.save
  end

  def success?
    @success
  end
end