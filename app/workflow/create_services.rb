class CreateServices
  attr_accessor :name, :description, :user, :service

  def initialize(name: "", description: "", user: User.new)
    @name = name
    @description = description
    @user = user
  end

  def build
    self.service = Service.new(name: @name, description: @description, user: @user)
  end

end