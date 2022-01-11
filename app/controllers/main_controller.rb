class MainController < ApplicationController
  def index
    # use .now to remvoe the alerts popping up
    flash.now[:notice] = "Logged In Successfully"
    flash.now[:alert] = "Invalid email or password"
  end
end
