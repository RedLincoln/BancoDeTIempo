require 'rails_helper'

RSpec.describe Service, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id)}
  end

  describe 'finders' do
    let(:service1) { create(:service) }
    let(:service2) { create(:service) }

    describe 'services_not_made_by' do

      before(:each) do
        service1
        service2
      end

      it 'only gets services not made by a user' do
        services = Service.services_not_made_by(service1.user)

        expect(services).to eq([service2])
      end

      it 'gets all if user is not persistent' do
        services = Service.services_not_made_by(User.new)

        expect(services).to eq([service1, service2])
      end
    end
  end
end
