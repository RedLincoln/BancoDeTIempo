class Api::TransactionController < ApplicationController

  def index
    login_guard
    @transactions = @user.transactions
  end

  def show
    login_guard
    @transaction = Transaction.find(params[:id])
  end

  def create
    login_guard

    transaction = Transaction.new(transaction_params)

    if transaction.save
      render json: { message: 'Petición realizada satisfactoriamente' }
    else
      render json: { message: 'Errores al pedir servicio' }, status: :bad_request
    end
  end

  def update
    login_guard
    transaction = Transaction.find(params[:id])

    if transaction.update(transaction_update_params)
      render json: { message: 'Petición actualizada' }, status: :ok
    else
      render json: { errors: transaction.errors }, status: :bad_request
    end
  end

  def rate_client
    login_guard
    transaction = Transaction.find(params[:id])

    rate = transaction.client_rate.build(rate_params)
    if rate.save
      transaction.update(status: 'done')
      render json: { message: 'Valoración del cliente realizada' }, status: :ok
    else
      render json: { errors: rate.errors }, status: :bad_request
    end
  end

  def rate_owner
    login_guard
    transaction = Transaction.find(params[:id])

    rate = transaction.owner_rate.build(rate_params)
    if rate.save
      transaction.update(status: 'valued')
      transaction.client.update(balance: transaction.client.balance - transaction.duration)
      transaction.service.user.update(balance: transaction.service.user.balance + transaction.duration)
      render json: { message: 'Valoración del propietario realizada' }, status: :ok
    else
      render json: { errors: rate.errors }, status: :bad_request
    end
  end

  private

  def transaction_params
    params.permit(:datetime, :duration, :additional_information, :service_id, :status).merge(
        {datetime: params[:datetime].is_a?(Numeric) ? Time.at(params[:datetime] / 1000) : "",
         client: @user}
    )
  end

  def transaction_update_params
    hash = {}
    if params[:datetime]
      hash[:datetime] = params[:datetime].is_a?(Numeric) ? Time.at(params[:datetime] / 1000) : ""
    end
    params.permit(:duration, :additional_information, :service_id, :status).merge(hash)
  end

  def rate_params
    params.permit(:rating, :message)
  end
end
