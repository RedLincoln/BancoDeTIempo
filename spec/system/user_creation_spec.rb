require 'rails_helper'

RSpec.describe 'Register', type: :system do
  let(:email) { 'michael@example.com' }
  let(:name) { 'Michael' }

  it 'successful sign_up creates a notification for the administrators', js: true do
    visit sign_up_path
    page.find('[data-testid="name-field"]').set name
    page.find('[data-testid="email-field"]').set email
    page.find('[data-testid="submit-button"]').click

    expect(page). to have_selector('.notice')
    expect(current_path).to eq(root_path)
    expect(page). to have_selector('.notice')
    mail = ActionMailer::Base.deliveries.last

    expect(mail[:to].to_s).to eq("#{name} <#{email}>")

    user = User.find_by(email: email)

    expect(user).to_not be_confirmed

    notification = Notification.last

    expect(notification.scope).to eq('admin')
  end

end