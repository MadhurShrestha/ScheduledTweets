class PasswordResetsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      #Send email using background job using deliver_later
      #Go to the password mailer and we want to send the reset email but we want to include some paramters
      # So we know who to send that to so we say with and that's going to set up params inside of your mailer
      # very similar to params inside your controllers so we can  say params[:user] and access that user.
      PasswordMailer.with(user: @user).reset.deliver_now
    end
      redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset the password"
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MesssageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your token has expired. Please try again"
  end

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password was successfully updated.Please sign in."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)

  end
end
