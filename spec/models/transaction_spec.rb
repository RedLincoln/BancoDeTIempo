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

  describe 'date_format' do
    let(:transaction) { build_stubbed(:transaction,
                                      datetime: DateTime.new(2020, 10, 12))}

    it 'expect output format for dates' do
      expect(transaction.date_format).to eq('12/10/2020')
    end

  end

  describe 'duration_range' do
    let(:transaction) { build_stubbed(:transaction,
                                      datetime: DateTime.new(2020, 2, 2, 10, 25, 0),
                                      duration: 2)}

    let(:single_digit_min_transaction) { build_stubbed(:transaction,
                                      datetime: DateTime.new(2020, 2, 2, 10, 3, 0),
                                      duration: 2)}

    it 'must be in a specific output format' do
      expect(transaction.duration_range).to eq('10:25-12:25')
    end

    it 'minutes must be 2 digits' do
      expect(single_digit_min_transaction.duration_range).to eq('10:03-12:03')
    end
  end

  describe 'filters' do
    let(:transaction) { build_stubbed(:transaction) }

    it 'to_json' do
      expect(transaction.to_json).to eql({service: transaction.service}.to_json)
    end
  end

  describe 'status' do
    include ActiveSupport::Testing::TimeHelpers
    # dd/mm/yyyy HH:MM
    # 10/10/2020 10:00 duration 2 hours
    let(:transaction) { create(:transaction,
                                      datetime: DateTime.new(2020, 10, 10, 10, 0),
                                      duration: 2)}

    it 'default status is negotiating' do
      expect(transaction).to be_negotiating
    end

    it 'can change from negotiating to accepted' do
      transaction.accepted!
      expect(transaction).to be_accepted
    end

    it 'can change from negotiating to canceled' do
      transaction.canceled!
      expect(transaction).to be_canceled
    end

    it 'status changes from accepted to done when datetime is less than now' do
      transaction.accepted!
      travel_to DateTime.new(2020, 10, 10, 18, 0) # 6 hours after datetime
      expect(transaction).to be_done
    end

    it 'status changes from negotiating to canceled when datetime is less thatn now' do
      transaction.negotiating!
      travel_to DateTime.new(2020, 10, 10, 18, 0) # 6 hours after datetime
      expect(transaction).to be_canceled
    end

  end
end
