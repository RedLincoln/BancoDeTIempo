require 'rails_helper'

RSpec.describe Message, type: :model do

  describe 'validation' do
    it {should validate_presence_of(:message)}
  end
end
