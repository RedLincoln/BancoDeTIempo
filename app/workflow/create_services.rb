class CreateServices
  attr_accessor :name, :description, :user, :valid, :service

  def initialize(name: "", description: "", user: nil, category_id: -1)
    @name = name
    @description = description
    @category_id = category_id
    @user = user
    @valid = false
  end

  def build
    if user.nil?
      self.service = Service.new(name: @name, description: @description, category: @category)
    else
      self.service = @user.services.build(name: @name, description: @description, category: category)
    end
  end

  def create
    build
    @valid = service.save
  end

  def valid?
    @valid
  end

  private

  def category
    Category.exists?(@category_id) ? Category.find(@category_id) : Category.new
  end

end