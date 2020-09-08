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

      find(".make-service-petition").click

      within "form.service-petition" do
        find(".transaction-datetime", visible: false).execute_script("this.value = '2020/06/07 12:00'")
        fill_in('addition-information', with: 'Pintar casa')
        fill_in('transaction-duration', with: '2')
        find(".send-petition").click
      end

      visit user_account_path

      within "#transaction-list #service-#{service.id}-petition" do
        expect(page).to have_selector('.service-name', text: service.name)
        expect(page).to have_selector('.service-description', text: service.description)
        expect(page).to have_selector('.date-and-duration', text:'07/07/2020 12:00-14:00')
        expect(page).to have_selector('.additional-information', text: 'Pintar casa')
        expect(page).to have_selector('.transaction-status')
        expect(page).to have_selector('.service-owner', text: offeringUser.name)
      end
    end
  end

end