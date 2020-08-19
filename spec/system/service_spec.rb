require 'rails_helper'

RSpec.describe 'Service', type: :system, js: true do
  let(:user) { create(:user) }

  describe "creation" do

    before(:each) do
      sign_in user
      visit new_service_path
    end

    it 'can be created', :aggregate_failures do
      fill_in('service_name', with: 'Pintar')
      fill_in('service_description', with: 'pintar tanto exteriores como interiores')
      find('form input[type="submit"]').click

      visit services_path

      service = Service.where(name: 'Pintar').first

      expect(page).to have_selector("#service_#{service.id} .service_name", text: 'Pintar')
      expect(page).to have_selector("#service_#{service.id} .service_description", text: 'pintar tanto exteriores como interiores')
    end

    it 'show errors on bad creation', :aggregate_failures do
      find('form input[type="submit"]').click

      expect(page).to have_selector("form .errors .error_name")
      expect(page).to have_selector("form .errors .error_description")
    end

    it 'error creating have to stay in the same url' do
      click_on('Crear servicio')
      expect(current_path).to eq(new_service_path)
    end
  end

  describe "edit" do
    let(:service) { create(:service) }

    before(:each) do
      sign_in service.user
      visit edit_service_path(service.id)
    end

    it "initial state is service data", :aggregate_failures do
      expect(page.find('#service_name')[:value]).to eq(service.name)
      expect(page).to have_selector('#service_description', text: service.description)
    end

    it "changes are made" do
      fill_in('service_name', with: "#{service.name}_1")
      find("form input[type=\"submit\"]").click

      visit services_path

      expect(page).to have_selector("#service_#{service.id} .service_name", text: "#{service.name}_1")
    end

    it "errors are shown" do
      fill_in('service_name', with: "")
      find("form input[type=\"submit\"]").click

      visit services_path

      expect(page).to have_selector("form .errors .error_name")
    end

  end

end