require 'rails_helper'


RSpec.describe CreateMessages do
  let(:author) { create(:user) }
  let(:service_petition) { create(:transaction) }

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

    expect(creator).to be_success
    expect(Message.exists?(message: 'This is a Message')).to eq(true)
  end

  describe 'not a success' do

    it 'author no in database' do
      creator = CreateMessages.new(message: 'This is a Message', author: User.new, service_petition: service_petition)
      creator.create

      expect(creator).to_not be_success
      expect(Message.exists?(message: 'This is a Message')).to eq(false)
    end

    it 'service_petition not in database' do
      creator = CreateMessages.new(message: 'This is a Message', author: author, service_petition: Transaction.new)
      creator.create

      expect(creator).to_not be_success
      expect(Message.exists?(message: 'This is a Message')).to eq(false)
    end

    it 'message is empty not in database' do
      creator = CreateMessages.new(message: '', author: author, service_petition: service_petition)
      creator.create

      expect(creator).to_not be_success
      expect(Message.all.count).to eq(0)
    end

  end

end
