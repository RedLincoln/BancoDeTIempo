class Api::TagsController < ApplicationController

  def index
    render json: { tags: Tag.all }
  end

end
