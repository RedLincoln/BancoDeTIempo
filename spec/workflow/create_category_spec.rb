require 'rails_helper'

RSpec.describe CreateCategories do

  it "can create Categories" do
    creator = CreateCategories.new(name: 'Class', supcategory: 'Learning')
    creator.build

    expect(creator.category.name).to eq('Class')
    expect(creator.category.supcategory).to eq('Learning')
  end

  describe 'not successful' do
    it 'empty name' do
      creator = CreateCategories.new(supcategory: 'Learning')
      creator.create
      expect(creator).to_not be_success
    end
  end
end