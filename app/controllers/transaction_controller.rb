class TransactionController < ApplicationController
  before_action :authenticate_user!

  def create
    @workflow = CreateTransactions.new(datetime: params[:transaction][:datetime],
                                       addition_information: params[:transaction][:addition_information],
                                       service_id: params[:transaction][:serviceId],
                                       client: current_user)
    @workflow.create
  end
end
