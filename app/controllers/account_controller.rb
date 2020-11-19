class AccountController < ApplicationController


  def index
    if params[:transaction_type].nil?
      @transactions = current_user.transactions
    elsif params[:transaction_type] == 'owner'
      @transactions = current_user.transactions_owner.order(created_at: :desc)
    elsif params[:transaction_type] == 'client'
      @transactions = current_user.transactions_client.order(created_at: :desc)
    end
  end
end
