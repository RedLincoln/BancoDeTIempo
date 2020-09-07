require 'rails_helper'

RSpec.describe 'Service', type: :system do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:service) { create(:service) }

  it 'creator can not see the service in the services main page' do
    sign_in service.user

    visit services_path

    expect(page).to_not have_selector("#service_#{service.id}")
  end

  describe "creation" do
    let(:category) { create(:category) }

    before(:each) do
      sign_in user
      visit new_service_path
    end

    it 'can be created', :aggregate_failures do
      category
      visit new_service_path
      fill_in('service_name', with: 'Pintar')
      select category.name, from: 'service_category'
      fill_in('service_description', with: 'pintar tanto exteriores como interiores')
      find('form input[type="submit"]').click

      sign_out user
      sign_in user2

      visit services_path

      service = Service.where(name: 'Pintar').first

      expect(page).to have_selector("#service_#{service.id} .service_name", text: 'Pintar')
      expect(page).to have_selector("#service_#{service.id} .service_description", text: 'pintar tanto exteriores como interiores')
    end

    it 'show errors on bad creation', :aggregate_failures do
      find('form input[type="submit"]').click

      expect(page).to have_selector("form .errors .error_name")
      expect(page).to have_selector("form .errors .error_description")
      expect(page).to have_selector("form .errors .error_category")
    end

    it 'error creating have to stay in the same url', js: true do
      click_on('Crear servicio')
      expect(current_path).to eq(new_service_path)
    end
  end

  describe "edit" do
    let(:service) { create(:service) }
    let(:category) { create(:category) }

    before(:each) do
      category
      sign_in service.user
      visit edit_service_path(service.id)
    end

    it "initial state is service data", :aggregate_failures do
      expect(page.find('#service_name')[:value]).to eq(service.name)
      expect(page).to have_select('service_category', selected: service.category.name)
      expect(page).to have_selector('#service_description', text: service.description)
    end

    it "changes are made" do
      fill_in('service_name', with: "#{service.name}_1")
      find("form input[type=\"submit\"]").click

      sign_out user
      sign_in user2

      visit services_path

      expect(page).to have_selector("#service_#{service.id} .service_name", text: "#{service.name}_1")
    end

    it "errors are shown", js: true do
      fill_in('service_name', with: "")
      find("form input[type=\"submit\"]").click

      expect(page).to have_selector("form .errors .error_name")
    end
  end

  describe 'filter:' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:service_result1) { create(:service, category: category)}
    let(:service_result2) { create(:service, category: category)}
    let(:service) { create(:service)}

    before(:each) do
      sign_in user
      service_result1
      service_result2
      service
      visit services_path
    end

    it 'can filter by Category', js: true do
      fill_in('filter_category', with: category.name)

      find('#service_filter .apply_filters').click

      expect(page).to have_selector("#service_#{service_result1.id}")
      expect(page).to have_selector("#service_#{service_result2.id}")
      expect(page).to_not have_selector("#service_#{service.id}")
    end
  end

end