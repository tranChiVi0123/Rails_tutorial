class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        login_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_to user
      else
        message = I18n.t(:account_not_activated)
        message += I18n.t(:please_check_your_mail)
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = I18n.t(:invalid_email_combination)
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
