require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:supcategory) }
    it { should validate_uniqueness_of(:name) }
  end

  it 'finds grouped by supcategory' do
    supcategory = 'SUPCATEGORY'
    category1 = create(:category, supcategory: supcategory)
    category2 = create(:category, supcategory: supcategory)
    category3 = create(:category, supcategory: 'Another_category')

    expected = {
        category1.supcategory => [category1, category2],
        category3.supcategory => [category3]
    }

    expect(Category.grouped_by_supcategory).to eq(expected)
  end
end
