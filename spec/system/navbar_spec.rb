require 'rails_helper'

RSpec.describe 'Navbar', type: :system do
  let(:user) { create(:user) }


  it 'have login button when user is not logged in', :aggregate_failures do
    visit root_path

    within('#navbar #session_actions') do
      expect(page).to have_selector('.login_button', text: 'Iniciar sesión')
      click_on('Iniciar sesión')
    end

    expect(current_path).to eq(new_user_session_path)
  end
end
