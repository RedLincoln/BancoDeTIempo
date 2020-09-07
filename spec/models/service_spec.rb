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
    let(:category1) { create(:category, name: 'AcceptCategory')}
    let(:category2) { create(:category, name: 'BadCategory')}
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

    before(:each) do
      service1
      service2
      service3
    end

    it "can get a fixed amount" do
      expect(Service.all.amount(2).to_a).to eql([service1, service2])
    end
  end
end
