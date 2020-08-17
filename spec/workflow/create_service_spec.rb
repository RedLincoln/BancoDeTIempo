require 'rails_helper'

RSpec.describe CreateServices do
  let(:user) { build_stubbed(:user) }

  it "creates a service with name and description" do
    creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: user)
    creator.build
    expect(creator.service.name).to eq('Pintar')
    expect(creator.service.description).to eq('La casa')
    expect(creator.service.user.name).to eq(user.name)
  end

  it "properly indicates when is valid", true do
    creator = CreateServices.new(name: 'Pintar', description: 'La casa', user: user)
    creator.create
    expect(creator).to be_valid
  end

end