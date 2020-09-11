require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe 'associations' do
    it { should belong_to(:user)}
  end

  describe 'validations' do
    it { should validate_presence_of(:message)}
    it { should validate_presence_of(:target)}
  end

  describe 'default' do
    let(:notification) { build_stubbed(:notification)}

    it 'seen' do
      expect(notification.seen).to eq(false)
    end

  end

  describe 'filter' do
    let(:notification) { build_stubbed(:notification)}

    it 'to_json' do
      notification

      expected = {
          id: notification.id,
          message: notification.message,
          target: notification.target,
          seen: notification.seen,
          link: notification.link,
          time_ago: "hace #{notification.created_ago}"
      }.to_json

      expect(notification.to_json).to eql(expected)
    end
  end

  describe 'created_ago' do
    include ActiveSupport::Testing::TimeHelpers

    let(:notification) { build_stubbed(:notification)}

    it 'a notification just created must be created 0 seconds ago' do
      notification
      expect(notification.created_ago).to eq('0 segundos')
    end

    it 'a notification created over 60 seconds have to be transformed to minutes' do
      notification
      travel 100.second
      expect(notification.created_ago).to eq('1 minuto')
    end

    it 'a notification created equal or over 2 minutes have to be in plural' do
      notification
      travel 260.second
      expect(notification.created_ago).to eq('4 minutos')
    end

    it 'a notification created over 60 minutes have to be transformed into hours' do
      notification
      travel 62.minute
      expect(notification.created_ago).to eq('1 hora')
    end

    it 'a notification created over 1 hour ago have to in plural' do
      notification
      travel 3.hour
      expect(notification.created_ago).to eq('3 horas')
    end

    it 'a notification created over 24 hours ago have to be transformed into days' do
      notification
      travel 25.hour
      expect(notification.created_ago).to eq('1 dia')
    end

    it 'a notification created equal or over 2 days ago have to be in plural' do
      notification
      travel 50.hour
      expect(notification.created_ago).to eq('2 dias')
    end
  end

end
