require 'rails_helper'


RSpec.describe CreateMessages do
  let(:author) { build_stubbed(:user) }
  let(:service_petition) { build_stubbed(:transaction) }

  it 'initial values' do
    creator = CreateMessages.new(message: 'This is a Message', author: author, service_petition: service_petition)
    creator.build

    expect(creator.message.message).to eq('This is a Message')
    expect(creator.message.author).to eq(author)
    expect(creator.message.service_petition).to eq(service_petition)
  end

  it 'successfully create valid messages' do
    creator = CreateMessages.new(message: 'This is a Message', author: author, service_petition: service_petition)
    creator.create

    expect(creator).to be_successful
    expect(Message.exists?(message: 'This is a Message')).to eq(true)
  end

end