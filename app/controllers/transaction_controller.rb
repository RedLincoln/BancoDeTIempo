class TransactionController < ApplicationController
  before_action :authenticate_user!
  before_action :get_transaction, only: [:edit, :update, :accept, :cancel]

  def edit
    @service = @transaction.service
  end

  def update
    if @transaction.update(transaction_params)
      respond_to do |format|
        format.js { render json: {notice: 'Petición actualizada'}.to_json }
      end
    else
      respond_to do |format|
        format.js { render json: {message: 'Error al actualizar la petición', errors: @transaction.errors}, status: :bad_request }
      end
    end
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


  def accept
    @transaction.accepted!
    if @transaction.accepted?
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render status: :bad_request }
      end
    end
  end

  def cancel
    @transaction.canceled!
    if @transaction.canceled?
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render status: :bad_request }
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

  def get_transaction
    @transaction = Transaction.find(params[:id])
  end
end
