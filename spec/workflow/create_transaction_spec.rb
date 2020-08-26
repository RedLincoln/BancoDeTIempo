require 'rails_helper'

RSpec.describe CreateTransactions do
  let(:service) { create(:service) }
  let(:user) { create(:user) }

  it 'can build transactions' do
    creator = CreateTransactions.new(datetime: 'anyday', additional_information: 'anywhere', service_id: service.id,
                                     client: user)
    creator.build
    expect(creator.transaction.datetime).to eq('anyday')
    expect(creator.transaction.additional_information).to eq('anywhere')
    expect(creator.transaction.service).to eq(service)
    expect(creator.transaction.client).to eq(user)
  end
end