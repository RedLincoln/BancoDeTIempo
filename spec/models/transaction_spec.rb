require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'associations' do
    it { should belong_to(:client).class_name(:User) }
    it { should belong_to(:service) }
  end

  describe 'default' do

    it 'status' do
      expect(Transaction.new.status).to eq('pending')
    end
  end
end
