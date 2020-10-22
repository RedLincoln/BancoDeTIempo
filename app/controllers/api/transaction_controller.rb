class Api::TransactionController < ApplicationController

  def index
    login_guard
    @transactions = @user.transactions
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

    if transaction.update(transaction_params)
      render status: :ok
    else
      render status: :bad_request
    end
  end

  private

  def transaction_params
    params.permit(:datetime, :duration, :additional_information, :service_id).merge(
        {datetime: params[:datetime].is_a?(Numeric) ? Time.at(params[:datetime] / 1000) : "",
         client: @user}
    )
  end

end
