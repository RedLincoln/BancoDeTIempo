module AdminHelpers
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  private
  def authenticate_admin
    redirect_to root_url unless admin_signed_in?
  end
end