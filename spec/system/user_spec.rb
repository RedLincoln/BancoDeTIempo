require 'rails_helper'

RSpec.describe 'sign_up User', type: :system do

  it 'can create new user' do
    visit new_user_registration_path
    fill_in('user_name', with: 'George Lucas')
    fill_in('user_email', with: 'example@gmail.com')
    fill_in('user_password', with: 'password')
    fill_in('user_password_confirmation', with: 'password')
    click_on('Crear cuenta')
    visit user_index_path

    expect(page).to have_selector('#user_name', text: 'George Lucas')
    expect(page).to have_selector('#user_email', text: 'example@gmail.com')
  end
end