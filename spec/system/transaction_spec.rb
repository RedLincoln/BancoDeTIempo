require 'rails_helper'

RSpec.describe 'Service Transactions' do
  let(:requestUser) { create(:user) }
  let(:offeringUser) { create(:user) }
  let(:service) { create(:service, user: offeringUser) }
  let(:transaction) { create(:transaction, service: service, client: requestUser) }


  describe 'transaction petition' do

    before(:each) do
      sign_in requestUser
      transaction
    end

    it 'User can ask for services' do
      visit services_path

      within "service_#{service.id}" do
        find(".open_petition").click
        fill_in('time_petition', with:'07/07/2020, 12:00')
        fill_in('additional_information', with: 'Pintar casa')
        find(".send_petition").click
      end

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

  end

end