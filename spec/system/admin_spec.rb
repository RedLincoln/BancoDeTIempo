require 'rails_helper'

RSpec.describe 'Admin', type: :system do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  describe 'integration' do
    before(:each) do
      sign_in admin
    end

    it 'can create categories' do
      visit new_category_path

      fill_in('category_name', with: 'Clases')
      fill_in('category_supcategory', with: 'Enseñansa')
      find('input[type="submit"]').click

      visit categories_path

      expect(page).to have_selector('.category_name', text: 'Clases')
      expect(page).to have_selector('.category_supcategory', text: 'Enseñansa')
    end
  end

  describe 'admin protected routes' do

    it 'new category' do
      visit new_category_path
      expect(current_path).to eq(root_path)
    end

  end
end