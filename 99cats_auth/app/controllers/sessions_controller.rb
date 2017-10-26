class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new
    render :new
  end

  def create #sign in
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      user.reset_session_token
      login_user!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    self.current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
