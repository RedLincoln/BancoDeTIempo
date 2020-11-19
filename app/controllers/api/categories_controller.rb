class Api::CategoriesController < ApplicationController

  def index
    render json: { categories: Category.all }
  end
end
