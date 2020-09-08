require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'associations' do
    it { should belong_to(:client).class_name(:User) }
    it { should belong_to(:service) }
  end

  describe 'validation' do
    let(:service) { create(:service) }
    let(:user) { create(:user) }

    it { should validate_presence_of(:datetime) }
    it { should validate_numericality_of(:duration).only_integer }
    it { should validate_numericality_of(:duration).is_greater_than(0) }
    it { should validate_numericality_of(:duration).is_less_than(24) }

    it 'service owner can not be the client' do
      transaction = Transaction.new(service: service, client: service.user)

      expect(transaction).to_not be_valid
      expect(transaction.errors).to include(:client)
    end

    it 'valid when client and owner are different' do
      transaction = Transaction.new(datetime: "10/10/2020 10:30", duration: 2, service: service, client: user)

      expect(transaction).to be_valid
    end

  end

  describe 'duration_range' do

    it '' do

    end
  end

  describe 'default' do

    it 'status' do
      expect(Transaction.new.status).to eq('pending')
    end
  end

  describe 'filters' do
    let(:transaction) { build_stubbed(:transaction) }

    it 'to_json' do
      expect(transaction.to_json).to eql({service: transaction.service}.to_json)
    end

  end
end
