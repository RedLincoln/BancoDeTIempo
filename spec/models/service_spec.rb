require 'rails_helper'

RSpec.describe Service, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id)}
  end

  describe 'finders' do
    let(:category1) { create(:category, name: 'AcceptCategory', supcategory: 'AcceptSupcategory')}
    let(:category2) { create(:category, name: 'BadCategory', supcategory: 'BadSupcategory')}
    let(:service1) { create(:service, category: category1) }
    let(:service2) { create(:service, category: category2) }

    describe 'find_by_category_name' do

      before(:each) do
        service1
        service2
      end

      it 'with no param returns all' do
        expect(Service.find_by_category_name.to_a).to eql([service1, service2])
      end

      it 'with nil return all' do
        expect(Service.find_by_category_name(nil).to_a).to eql([service1, service2])
      end

      it 'find by complete name' do
        expect(Service.find_by_category_name(category1.name).to_a).to eq([service1])
      end

      it 'find by portion of category name' do
        expect(Service.find_by_category_name('Category').to_a).to eq([service1, service2])
      end
    end

    describe 'find_by_category_supcategory' do

      before(:each) do
        service1
        service2
      end

      it 'with no param returns all' do
        expect(Service.find_by_category_supcategory.to_a).to eql([service1, service2])
      end

      it 'with nil return all' do
        expect(Service.find_by_category_supcategory(nil).to_a).to eql([service1, service2])
      end

      it 'find by complete name' do
        expect(Service.find_by_category_supcategory(category1.supcategory).to_a).to eq([service1])
      end

      it 'find by portion of category name' do
        expect(Service.find_by_category_supcategory('Category').to_a).to eq([service1, service2])
      end
    end

    describe 'services_not_made_by' do

      before(:each) do
        service1
        service2
      end

      it 'only gets services not made by a user' do
        services = Service.services_not_made_by(service1.user)

        expect(services).to eq([service2])
      end

      it 'gets all if user is not persistent' do
        services = Service.services_not_made_by(User.new)

        expect(services).to eq([service1, service2])
      end
    end
  end

  describe "pagination" do
    let(:service1) { create(:service) }
    let(:service2) { create(:service) }
    let(:service3) { create(:service) }
    let(:service4) { create(:service) }
    let(:service5) { create(:service) }
    let(:service6) { create(:service) }

    before(:each) do
      service1
      service2
      service3
      service4
      service5
      service6
      Service.set_default_page_size 5
    end

    it "can get a fixed amount" do
      expect(Service.all.amount(limit: 2).to_a).to eql([service1, service2])
    end

    it "can get a fixed amount with offset" do
      expect(Service.all.amount(limit: 2, offset: 1).to_a).to eql([service2, service3])
    end

    it "last page returns the last records" do
      expect(Service.all.pagination(page: 2).to_a).to eql([service6])
    end

    it "out of bound pages returns no record" do
      expect(Service.all.pagination(page: 3).to_a).to eql([])
      expect(Service.all.pagination(page: -1).to_a).to eql([])
    end

    it 'page 0 should return content of page 1' do
      expect(Service.all.pagination(page: 0).to_a).to eql([service1, service2, service3, service4, service5])
    end

    it "nil page return page 1" do
      expect(Service.all.pagination(page: nil).to_a).to eql([service1, service2, service3, service4, service5])
    end

    it "get the total of pages when the last page is not filled" do
      expect(Service.all.page_count).to eq(2)
    end

    it "get the total of pages when the last page is empty" do
      service6.destroy!
      expect(Service.all.page_count).to eq(1)
    end

    it "get the total of pages when there is no records" do
      Service.destroy_all
      expect(Service.all.page_count).to eq(1)
    end

  end
end
