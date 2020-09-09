class AccountController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:transaction_type].nil?
      @transactions = current_user.transactions
    elsif params[:transaction_type] == 'owner'
      @transactions = current_user.transactions_owner
    elsif params[:transaction_type] == 'client'
      @transactions = current_user.transactions_client
    end
  end
end
