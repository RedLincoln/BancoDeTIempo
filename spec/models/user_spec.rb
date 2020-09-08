require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { should have_many(:services)}
    it { should have_many(:transactions_client)}
    it { should have_many(:transactions_owner).through(:services)}
    it { should have_many(:notifications)}
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

  describe 'methods:' do
    let(:client) { create(:user) }
    let(:service) { create(:service)}
    let(:transaction) {create(:transaction, service: service, client: client)}


    it 'finds if a user have a transaction with a service' do
      transaction

      expect(client.have_transaction?(service)).to be(true)
    end

    it 'finds if a user have a transactions as a client' do
      transaction

      expect(client.have_transaction_as_client?(service)).to be(true)
    end

    it 'finds if a user have a transactions as a owner' do
      transaction

      expect(service.user.have_transaction_as_owner?(service)).to be(true)
    end

    describe 'notification finder' do
      let(:userNotification) { create(:notification )}

      it 'finds notification when user owns the notification' do
        userNotification

        expect(userNotification.user.find_notification(userNotification.id)).to eql(userNotification)
      end

      it 'raise exception when the notification is not found' do
        expect{ client.find_notification(1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end