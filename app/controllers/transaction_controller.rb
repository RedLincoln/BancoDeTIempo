class TransactionController < ApplicationController
  before_action :authenticate_user!

  def edit
    @transaction = Transaction.find(params[:id])
    @service = @transaction.service
  end

  def new
    @service = Service.find(params[:id])
    @transaction = Transaction.new
  end

  def create
    @workflow = CreateTransactions.new(transaction_params)
    @workflow.create

    if @workflow.success?
      respond_to do |format|
        format.js { render json: { message: 'Petición realisada'} }
      end
    else
      respond_to do |format|
        format.js { render json: {message: 'Error al realizar la petición', errors: @workflow.transaction.errors}, status: :bad_request }
      end
    end

  end

  private

  def transaction_params
    datetime = (params[:transaction][:datetime].is_a?(Numeric)) ? Time.at(params[:transaction][:datetime] / 1000) : ""
    {
        datetime: datetime,
        duration: params[:transaction][:duration],
        addition_information: params[:transaction][:addition_information],
        service_id: params[:transaction][:service_id],
        client: current_user
    }
  end
end
