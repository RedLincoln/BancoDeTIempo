class TransactionController < ApplicationController
  before_action :authenticate_user!

  def create
    @workflow = CreateTransactions.new(transaction_params)
    @workflow.create

    if @workflow.success?
      respond_to do |format|
        format.js { render json: {message: 'goood'} }
      end
    else
      respond_to do |format|
        format.js { render json: {message: 'bad'} }
      end
    end

  end

  private

  def transaction_params
    {
        datetime: params[:transaction][:datetime],
        addition_information: params[:transaction][:addition_information],
        service_id: params[:transaction][:service_id],
        client: current_user
    }
  end
end
