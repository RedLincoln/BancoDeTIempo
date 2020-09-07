require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'associations' do
    it { should have_many(:services) }
  end

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

  describe 'search by name' do
    let(:category) { create(:category, name: 'Hola Mundo')}
    let(:category2) { create(:category, name: 'Buscar por nombre')}

    before(:each) do
      category
      category2
    end

    it 'returns all Categories with empty search_string' do
      results = Category.search_by_name('')

      expect(results).to eql([category, category2])
    end

    it 'returns all Categories with nil search_string' do
      results = Category.search_by_name(nil)

      expect(results).to eql([category, category2])
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

    # Ho(la M)undo
    it 'it ignores whitespaces' do
      results = Category.search_by_name('laM')

      expect(results).to eql([category])
    end

    it 'can search with whitespaces in search_query' do
      results = Category.search_by_name('o la')

      expect(results).to eql([category])
    end
  end

  describe 'search by supcategory' do
    let(:category) { create(:category, supcategory: 'Hola Mundo')}
    let(:category2) { create(:category, supcategory: 'Buscar por nombre')}

    before(:each) do
      category
      category2
    end

    it 'returns all Categories with empty search_string' do
      results = Category.search_by_supcategory('')

      expect(results).to eql([category, category2])
    end

    it 'returns all Categories with nil search_string' do
      results = Category.search_by_supcategory(nil)

      expect(results).to eql([category, category2])
    end

    it 'search categories with supcategories containing a letter' do
      results = Category.search_by_supcategory('H')

      expect(results).to eql([category])
    end

    # Hola M<-undo
    # Buscar por nom<-bre
    it 'is case-insensitive' do
      results = Category.search_by_supcategory('M')

      expect(results).to eql([category, category2])
    end

    # Ho(la M)undo
    it 'it ignores whitespaces' do
      results = Category.search_by_supcategory('laM')

      expect(results).to eql([category])
    end

    it 'can search with whitespaces in search_query' do
      results = Category.search_by_supcategory('o la')

      expect(results).to eql([category])
    end
  end
end
