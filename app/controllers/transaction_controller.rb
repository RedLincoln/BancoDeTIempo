class TransactionController < ApplicationController
  before_action :authenticate_user!

  def create
    respond_to do |format|
      format.js { render json: {message: 'goood'} }
    end
  end
end
