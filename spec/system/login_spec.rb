require 'rails_helper'

RSpec.describe 'Login', type: :system do
  let(:user) { create(:user) }

  it 'success login', js: true do
    user
    visit login_path
    page.find('[data-testid="email-field"]').set user.email
    page.find('[data-testid="password-field"]').set user.password
    page.find('[data-testid="submit-btn"]').click

    expect(page).to have_selector('.notice')
    expect(current_path).to eq(root_path)

    expect(page).to have_selector('.avatar')
    expect(page).to_not have_selector('[data-testid="login-btn"]')
    expect(page).to_not have_selector('[data-testid="sign_up-btn"]')
  end
end