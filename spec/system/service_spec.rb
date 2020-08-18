require 'rails_helper'

RSpec.describe 'Service', type: :system, js: true do
  let(:user) { create(:user) }

  it 'can be created', :aggregate_failures do
    sign_in user
    visit new_service_path

    fill_in('service_name', with: 'Pintar')
    fill_in('service_description', with: 'pintar tanto exteriores como interiores')
    click_on('Crear servicio')

    expect(current_path).to eq(services_path)

    service = Service.where(name: 'Pintar').first

    expect(page).to have_selector("#service_#{service.id} .service_name", text: 'Pintar')
    expect(page).to have_selector("#service_#{service.id} .service_description", text: 'pintar tanto exteriores como interiores')
  end

  it 'show errors on bad creation', :aggregate_failures do
    sign_in user
    visit new_service_path

    click_on('Crear servicio')

    expect(page).to have_selector("form .errors .error_name")
    expect(page).to have_selector("form .errors .error_description")
  end

end