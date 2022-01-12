class SessionsController < ApplicationController
  def new

  end

  def create
    # User.find_by(email: aayush25@gmail.com)
    user = User.find_by(email: params[:email])
    # if the user is present and authenticates with their password
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
        redirect_to root_path, notice: "Successful Login"
    else
      flash[:alert] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
