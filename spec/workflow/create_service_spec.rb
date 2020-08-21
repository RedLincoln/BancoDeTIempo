require 'rails_helper'

RSpec.describe CreateServices do
  let(:user) { build_stubbed(:user) }
  let(:category) { create(:category) }

  it "creates a service with name and description" do
    creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: user)
    creator.build
    expect(creator.service.name).to eq('Pintar')
    expect(creator.service.description).to eq('La casa')
    expect(creator.service.user.name).to eq(user.name)
  end

  it "properly indicates when is valid" do
    creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: user, category_id: category.id)
    creator.create
    expect(creator).to be_valid
  end

  describe "not valid" do
    it "name" do
      creator = CreateServices.new(description: 'La casa', user: user, category_id: category.id)
      creator.create
      expect(creator).to_not be_valid
    end

    it "description" do
      creator = CreateServices.new(name: 'Pintar', user: user, category_id: category.id)
      creator.create
      expect(creator).to_not be_valid
    end

    it "user is nil" do
      creator = CreateServices.new(name: 'Pintar', description: 'La casa', category_id: category.id)
      creator.create
      expect(creator).to_not be_valid
    end

    it "user is not an instance of User model" do
      creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: '', category_id: category.id)
      creator.create
      expect(creator).to_not be_valid
    end

    it "user instance of User model but not valid" do
      creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: User.new, category_id: category.id)
      creator.create
      expect(creator).to_not be_valid
    end
  end


end