require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:supcategory) }
    it { should validate_uniqueness_of(:name).scoped_to(:supcategory) }
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

  it 'to_json format' do
    category = build_stubbed(:category)
    expected = {
        id: category.id,
        name: category.name,
        supcategory: category.supcategory
    }.to_json

    expect(category.to_json).to eql(expected)
  end

  describe 'seach by name' do
    let(:category) { create(:category, name: 'Hola Mundo')}
    let(:category2) { create(:category, name: 'Buscar por nombre')}

    before(:each) do
      category
      category2
    end

    it 'search categories with names containing a letter' do
      results = Category.search_by_name('H')

      expect(results).to eql([category])
    end

    # Hola M<-undo
    # Buscar por nom<-bre
    it ' is case-insensitive' do
      results = Category.search_by_name('M')

      expect(results).to eql([category, category2])
    end
  end
end
