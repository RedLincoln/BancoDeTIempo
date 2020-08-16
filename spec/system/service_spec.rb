require 'rails_helper'

RSpec.describe 'Service', type: :system, js: true do

  it 'can be created', :aggregate_failures do
    visit new_service_path

    fill_in('service_name', with: 'Pintar')
    fill_in('service_description', with: 'pintar tanto exteriores como interiores')
    click_on('Crear servicio')

    expect(current_path).to eq(service_path(1))

    expect(page).to have_selector('.service_name', text: 'Pintar')
    expect(page).to have_selector('.service_description', text: 'pintar tanto exteriores como interiores')
  end

end