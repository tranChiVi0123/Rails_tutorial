class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] # Case (1)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email params[:locale]
      flash[:info] = I18n.t(:email_sent_reset)
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t(:email_not_found)
      render :new
    end
  end

  def update
    if params[:user][:password].empty? # Case (3)
      @user.errors.add(:password, I18n.t(:cant_be_empty))
      render :edit
    elsif @user.update(user_params) # Case (4)
      login_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = I18n.t(:password_has_been_reset)
      redirect_to @user
    else
      render :edit # Case (2)
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless @user&.activated? && @user&.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = I18n.t(:password_reset_has_expired)
      redirect_to new_password_reset_url
    end
  end
end
