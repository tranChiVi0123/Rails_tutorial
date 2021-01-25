class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation user, locale
    @user = user
    @locale = locale
    mail to: user.email, subject: I18n.t(:subject_account_activation)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset user, locale
    @user = user
    @locale = locale
    mail to: user.email, subject: I18n.t(:reset_password)
  end
end
