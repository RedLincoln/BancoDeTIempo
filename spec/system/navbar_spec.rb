require 'rails_helper'

RSpec.describe 'Navbar', type: :system, js: true do
  let(:user) { create(:user) }


  it 'have login button when user is not logged in', :aggregate_failures do
    visit root_path

    within('#navbar #session_actions') do
      expect(page).to have_selector('.login_button', text: 'Iniciar sesión')
      click_on('Iniciar sesión')
    end

    expect(current_path).to eq(new_user_session_path)
  end

  it 'have sign_up button when user is not logged in', :aggregate_failures do
    visit root_path

    within('#navbar #session_actions') do
      expect(page).to have_selector('.sign_up_button', text: 'Registrarse')
      click_on('Registrarse')
    end

    expect(current_path).to eq(new_user_registration_path)
  end

  it 'have only logout button when user is logged in', :aggregate_failures do
    sign_in user
    visit root_path

    within('#navbar #session_actions') do
      expect(page).to_not have_selector('.login_button', text: 'Iniciar sesión')
      expect(page).to_not have_selector('.sign_up_button', text: 'Registrarse')
      expect(page).to have_selector('.logout_button', text: 'Cerrar sesión')
      find('.logout_button', :text => 'Cerrar sesión').click
    end

    expect(current_path).to eq(root_path)
  end

  it "have user protected links" do
    expect(page).to_not have_selector('.service_link')

    sign_in user
    visit root_path

    within '#navbar' do
      page.find('.service_link').click

      expect(current_path).to eq(services_path)
    end


  end
end
