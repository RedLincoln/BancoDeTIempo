class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.where(service_petition: Transaction.find(params[:id]))
  end

  def create
    workflow = CreateMessages.new(message_params)
    workflow.create
  end

  private

  def message_params
    {
        service_petition: Transaction.find(params[:id]),
        author: current_user,
        message: params[:message]
    }
  end

end
