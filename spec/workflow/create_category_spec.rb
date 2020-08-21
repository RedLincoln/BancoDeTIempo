require 'rails_helper'

RSpec.describe CreateCategories do

  it "can create Categories" do
    creator = CreateCategories.new(name: 'Class', supcategory: 'Learning')
    creator.build

    expect(creator.category.name).to eq('Class')
    expect(creator.category.supcategory).to eq('Learning')
  end
end