class CreateServices
  attr_accessor :name, :description, :user, :valid, :service

  def initialize(name: "", description: "", user: User.new)
    @name = name
    @description = description
    @user = user
    @valid = false
  end

  def build
    self.service = Service.new(name: @name, description: @description, user: @user)
  end

  def create
    build
    @valid = service.save
  end

  def valid?
    @valid
  end

end