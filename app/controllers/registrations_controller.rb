class RegistrationsController < ApplicationController
  def new
    # Using instance variable that will look at the database table and attributes that we have on our user model
    # and will create a new one in memory and it will assign it to a variable
    # Using instance variable because instance variable can be used in our views so when we create an app/views/registrations/new.html.erb whereas local variable will only be available inside of this method
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account was created successfully"
    else
      render :new
    end
  end
    # User.new(email:"email@email.com",password:"password",password_confirmation: "password_confirmation")
    # params
    # {"authenticity_token"=>"[FILTERED]", "user"=>{"email"=>"test@gmail.com", "password"=>"[FILTERED]", "password_confirmations"=>"[FILTERED]"}, "commit"=>"Get Started"}

    # params[:user]
    # {user"=>{"email"=>"test@gmail.com", "password"=>"[FILTERED]", "password_confirmations"=>"[FILTERED]"}}

    private

    def user_params
      # Raises an error if the user is not found
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
