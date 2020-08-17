require 'rails_helper'

RSpec.describe CreateServices, type: :controller do
  let(:user) { create(:user) }

  it "creates a service with name and description" do
    sign_in user

    creator = CreateServices.new(name: 'Pintar', description: 'La casa')
    creator.build
    expect(creator.service.name).to eq('Pintar')
    expect(creator.service.description).to eq('La casa')
  end

end