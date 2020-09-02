class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_notification, only: [:update]

  def update
    if @notification.update(notifications_params)
      render json: { message: 'Actualizado de forma adecuada' }
    else
      render json: { message: 'No es posible encontrar la notificación', status: :not_found}
    end
  end

  private

  def notifications_params
    params.require(:notification).permit(:seen)
  end

  def get_notification
    @notification = current_user.find_notification(params[:id])
  end
end
