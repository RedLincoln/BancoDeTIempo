require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe 'associations' do
    it { should belong_to(:user)}
  end

  describe 'validations' do
    it { should validate_presence_of(:message)}
    it { should validate_presence_of(:target)}
  end

  describe 'filter' do
    let(:notification) { build_stubbed(:notification)}

    it 'to_json' do
      notification

      expected = {
          message: notification.message,
          target: notification.target,
      }.to_json

      expect(notification.to_json).to eql(expected)
    end
  end

  describe 'created_ago' do
    let(:notification) { build_stubbed(:notification)}

    it 'a notification just created must be created 0 seconds ago' do
      notification
      expect(notification.created_ago).to eq('0 segundos')
    end
  end

end
