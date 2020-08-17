class CreateServices
  attr_accessor :name, :description, :service

  def initialize(name: "", description: "")
    @name = name
    @description = description
  end

  def build
    @service = Service.new(name: @name, description: @description)
  end

end