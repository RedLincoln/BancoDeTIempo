require 'rails_helper'

RSpec.describe 'User Service', type: :system do
  let(:user) { create(:user) }
  let(:service1) { create(:service, user: user) }
  let(:service2) { create(:service, user: user) }
  let(:create_services) {
    service1
    service2
  }

  before(:each) do
    sign_in user
    visit user_services_path
  end

  it 'permit CURD actions on the services', :aggregate_failures do
    create_services
    page.find('.new_service_button').click
    expect(current_path).to eql(new_service_path)
    visit user_services_path

    expect(page).to have_selector("#service_#{service1.id} .name", text: service1.name)
    expect(page).to have_selector("#service_#{service2.id} .name", text: service2.name)

    within "#service_#{service1.id}" do
      page.find('.edit_service').click
      expect(current_path).to eq(edit_service_path(service1.id))
      visit user_services_path

      page.find('.delete_service').click
    end

    expect(current_path).to eq(user_services_path)
    expect(page).to_not have_selector("#service_#{service1.id}")

    expect{ user.find_service(service1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

end