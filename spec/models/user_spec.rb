require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { should have_many(:services)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'service and users relations' do
    let(:service1) { create(:service) }
    let(:service2) { create(:service) }

    it 'service search cant get service that are not owned by the user' do
      expect{ service1.user.find_service(service2.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'service search can find services owned by the user' do
      found_service = service1.user.find_service(service1.id)
      expect(found_service).to eq(service1)
    end
  end

  describe 'default' do
    let(:user) { build_stubbed(:user) }

    it 'role is standard' do
      expect(user).to be_standard
    end
  end

end