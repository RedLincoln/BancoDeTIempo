require 'rails_helper'

RSpec.describe 'Login', type: :system do

  it 'success login', js: true do
    visit login_path
    page.find('[data-testid="email-field"]').set "miguel@example.com"
    page.find('[data-testid="password-field"]').set "password"
  end
end