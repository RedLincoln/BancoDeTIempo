require 'rails_helper'

RSpec.describe 'Notifications', type: :system, js: true do
  let(:user) { create(:user) }
  let(:service) { create(:service, user: user)}
  let(:transaction) { create(:transaction, service: service) }

  before(:each) do
    sign_in user
    visit root_path
  end

  it 'show notification when service petitions are made' do
    notifications = find('#notifications')
    transaction

    within notifications do
      expect(page).to have_selector('#notifications-counter', text: '1')
    end

    notifications.click
    expect(page).to have_selector('#notifications-list')

    within '#notifications-list' do
      expect(page).to have_selector('.notification .target', text: service.name)
    end
  end
end