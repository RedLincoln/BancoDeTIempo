require 'rails_helper'

RSpec.describe 'Service Transactions', type: :system do
  let(:requestUser) { create(:user) }
  let(:offeringUser) { create(:user) }
  let(:service) { create(:service, user: offeringUser) }
  let(:service2) { create(:service) }
  let(:transaction) { create(:transaction, service: service, client: requestUser)}

  describe 'transaction petition' do

    before(:each) do
      sign_in requestUser
      service
    end

    it 'User can ask for services', :aggregate_failures, js: true do
      visit services_path

      within "#service_#{service.id}" do
        find(".open_petition").click
        fill_in('datetime', with:'07/07/2020, 12:00')
        fill_in('addition_information', with: 'Pintar casa')
        find(".send_petition").click
      end

      find('#flash-messages .notice')
      expect(page).to_not have_selector("#service_#{service.id} .open_petition")
      visit user_index_path

      within "#transaction_list #service_#{service.id}_petition" do
        expect(page).to have_selector('.service_name', text: service.name)
        expect(page).to have_selector('.service_description', text: service.description)
        expect(page).to have_selector('.time_petition', text:'07/07/2020, 12:00')
        expect(page).to have_selector('.additional_information', text: 'Pintar casa')
        expect(page).to have_selector('.transaction_status')
        expect(page).to have_selector('.offeror_name', text: offeringUser.name)
      end
    end

    it 'the ask button is always hided if a petition have already been made', js: true do
      transaction
      service2
      sign_in requestUser
      visit root_path

      visit services_path
      expect(page).to_not have_selector("#service_#{service.id} .open_petition")
      expect(page).to have_selector("#service_#{service2.id} .open_petition")
    end
  end

end