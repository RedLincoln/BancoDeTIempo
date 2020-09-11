class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.where(service_petition: Transaction.find(params[:id])).order(created_at: :desc)
  end

  def create
    workflow = CreateMessages.new(message_params)
    workflow.create

    if workflow.success?
      respond_to do |format|
        format.js { flash.now[:notice] = 'Mensaje enviado' }
      end
    else
      respond_to do |format|
        format.js { flash.now[:alert] = 'Mensaje sin contenido' }
      end
    end
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
