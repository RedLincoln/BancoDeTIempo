require 'rails_helper'

RSpec.describe 'Transaction Messages', type: :system, js: true do
  let(:owner){create(:user)}
  let(:client) {create(:user)}
  let(:service) { create(:service, user: owner)}
  let(:transaction){create(:transaction, service: service, client: client)}

  before(:each) do
    transaction
  end

  it 'can create messages' do
    sign_in owner
    visit user_account_path

    find("#service-#{transaction.id}-petition .messages").click
    find("#new-message").click

    fill_in('message', with: 'This is a message')
    find("#send-message").click

    visit transaction_messages_path

    expect(page).to have_selector(".message_list .message .content", text: 'This is a message')
  end

end