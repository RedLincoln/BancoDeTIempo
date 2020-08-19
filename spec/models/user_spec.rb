require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'service and users relations' do
    let(:service1) { create(:service) }
    let(:service2) { create(:service) }

    it 'service search cant get service that are not owned by the user' do
      expect(service1.user.findService(service2.id)).to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end