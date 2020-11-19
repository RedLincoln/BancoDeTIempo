# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/register_confirmation
  def register_confirmation
    UserMailerMailer.register_confirmation
  end

end
