require 'rails_helper'

RSpec.describe 'Service Transactions', type: :system do
  let(:request_user) { create(:user) }
  let(:offering_user) { create(:user) }
  let(:service) { create(:service, user: offering_user) }
  let(:service2) { create(:service, user: request_user) }
  let(:transaction_client) { create(:transaction, service: service, client: request_user)}
  let(:transaction_owner) { create(:transaction, service: service2)}

  describe 'transaction petition' do

    describe '' do
      before(:each) do
        sign_in request_user
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
        find("#transaction-list #service-#{service.id}-petition", wait: 5)

        within "#transaction-list #service-#{service.id}-petition" do
          expect(page).to have_selector('.service-name', text: service.name)
          expect(page).to have_selector('.service-description', text: service.description)
          expect(page).to have_selector('.date-and-duration', text:'07/07/2020 12:00-14:00')
          expect(page).to have_selector('.additional-information', text: 'Pintar casa')
          expect(page).to have_selector('.transaction-status')
          expect(page).to have_selector('.service-owner', text: offering_user.name)
        end
      end
    end
  end

  describe 'user transactions views' do

    before(:each) do
      page.driver.browser.manage.window.resize_to(1920, 1080)
      transaction_client
      transaction_owner
      sign_in request_user
      visit user_account_path
    end

    it 'have multiple tabs to show transactions ownership', js: true do
      expect(page).to have_selector("#transaction-list #service-#{transaction_client.service.id}-petition")
      expect(page).to have_selector("#transaction-list #service-#{transaction_owner.service.id}-petition")

      find('.offering-tab').click

      expect(page).to_not have_selector("#transaction-list #service-#{transaction_client.service.id}-petition")
      expect(page).to have_selector("#transaction-list #service-#{transaction_owner.service.id}-petition")

      find('.petition-tab').click

      expect(page).to have_selector("#transaction-list #service-#{transaction_client.service.id}-petition")
      expect(page).to_not have_selector("#transaction-list #service-#{transaction_owner.service.id}-petition")
    end
  end
end