require 'rails_helper'

RSpec.describe CreateTransactions do
  let(:service) { create(:service) }
  let(:user) { create(:user) }

  it 'can build transactions' do
    date = DateTime.now
    creator = CreateTransactions.new(datetime: date, duration: 2,
                                     addition_information: 'anywhere', service_id: service.id,
                                     client: user)
    creator.build
    expect(creator.transaction.datetime).to eq(date)
    expect(creator.transaction.duration).to eq(2)
    expect(creator.transaction.addition_information).to eq('anywhere')
    expect(creator.transaction.service).to eq(service)
    expect(creator.transaction.client).to eq(user)
  end

  it 'be successful' do
    creator = CreateTransactions.new(datetime: DateTime.now, duration: 2,
                                     addition_information: 'anywhere', service_id: service.id,
                                     client: user)
    creator.create

    expect(creator).to be_success
  end

  describe 'not successful' do

    it 'service owner is the client' do
      creator = CreateTransactions.new(datetime: DateTime.now, duration: 2, addition_information: 'anywhere', service_id: service.id,
                                       client: service.user)
      creator.create

      expect(creator).to_not be_success
    end

    it 'client is not set' do
      creator = CreateTransactions.new(datetime: DateTime.now, duration: 2, addition_information: 'anywhere', service_id: service.id)
      creator.create

      expect(creator).to_not be_success
    end

    it 'servcice exits' do
      creator = CreateTransactions.new(datetime: DateTime.now, duration: 2, addition_information: 'anywhere', service_id: -1, client: service.user)
      creator.create

      expect(creator).to_not be_success
    end
  end

end