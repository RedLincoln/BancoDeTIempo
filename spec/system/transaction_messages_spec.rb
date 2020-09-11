require 'rails_helper'

RSpec.describe 'Transaction Messages', type: :system do
  let(:owner){create(:user)}
  let(:client) {create(:user)}
  let(:service) { create(:service, user: owner)}
  let(:transaction){create(:transaction, service: service,
                           client: client, addition_information: "")}
  let(:message) { create(:message, message: 'Notification Message',
                         service_petition: transaction, author: owner) }

  before(:each) do
    transaction
  end

  it 'can create messages' do
    sign_in owner
    visit user_account_path

    find("#service-#{transaction.id}-petition .messages").click

    fill_in('message', with: 'This is a message')
    find("#send-message").click

    visit transaction_messages_path(transaction.id)

    expect(page).to have_selector(".message-list .message .content", text: 'This is a message')
  end

  it 'notifications are sent to the other participant when a message is created', js: true do
    message
    sign_in client
    visit root_path

    find("#notifications .toggle-button").click
    find("#notifications-list .notification").click

    expect(current_path).to eq(transaction_messages_path(transaction.id))
    expect(page).to have_selector(".message-list .message .content", text: message.message)

    sign_in owner
    expect(page).to have_selector("#notifications-counter", text: '0')
  end

  it 'client can edit the service petition', js: true do
    Notification.destroy_all
    sign_in client
    visit user_account_path

    find("#service-#{transaction.id}-petition .edit").click

    expect(current_path).to eq(edit_service_petition_path(transaction.id))

    fill_in('addition-information', with: 'Additional information')
    find(".send-petition").click

    sign_in owner
    visit user_account_path
    expect(page).to_not have_selector("#service-#{transaction.id}-petition .edit")
    expect(page).to have_selector("#transaction-list #service-#{service.id}-petition .additional-information",
                                  text: 'Additional information')


    find("#notifications .toggle-button").click
    find("#notifications-list .notification").click

    regex = Regexp.new(Regexp.escape('Additional information'), Regexp::IGNORECASE)
    expect(page).to have_selector(".message-list .transaction-edit")
  end
end