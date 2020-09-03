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
      expect(page).to have_selector('#notifications-counter', text: '1', wait: 5)
    end

    notifications.click
    expect(page).to have_selector('#notifications-list')

    within '#notifications-list' do
      expect(page).to have_selector('.notification .target', text: service.name)
    end
  end

  it 'have persistence while visiting others views', :aggregate_failures do
    transaction
    visit services_path


    expect(page).to have_selector('#notifications-counter', text: '1')
    find('#notifications').click

    expect(page).to have_selector('#notifications .notification .target', text: transaction.service.name)
  end

  it 'seen notifications does not add to the notification counter' do
    seen_notification = create(:notification, seen: true, user: user)
    not_seen_notification = create(:notification, seen: false, user: user)


    visit root_path

    expect(page).to have_selector('#notifications-counter', text: '1')
    find('#notifications').click

    expect(page).to have_selector('#notifications .notification .target', text: seen_notification.target)
    expect(page).to have_selector('#notifications .notification .target', text: not_seen_notification.target)
  end

  it 'click on unseen notification marks it seen' do
    sign_in user
    seen_notification = create(:notification, seen: true, user: user)
    not_seen_notification = create(:notification, seen: false, user: user)

    visit root_path

    find('#notifications').click
    find('#notifications .notification .target', text: not_seen_notification.target).click

    visit current_path

    expect(page).to have_selector('#notifications-counter', text: '0')
    find('#notifications').click

    expect(page).to have_selector('#notifications .notification .target', text: seen_notification.target)
    expect(page).to have_selector('#notifications .notification .target', text: not_seen_notification.target)
  end

end