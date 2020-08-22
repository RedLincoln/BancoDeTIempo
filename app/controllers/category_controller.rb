class CategoryController < ApplicationController
  def index
    @supcategories = Category.grouped_by_supcategory
  end

  def new
    @category = Category.new
  end

  def create
    workflow = CreateCategories.new(category_params)
    workflow.create
    redirect_to root_path, notice: 'Categoria creada'
  end

  private
  def category_params
    params.require(:category).permit(:name, :supcategory)
    {
        name: params[:category][:name],
        supcategory: params[:category][:supcategory]
    }
  end

end
