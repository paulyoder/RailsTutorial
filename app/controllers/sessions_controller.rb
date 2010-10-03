class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])

    if (user)
      sign_in user
      flash[:success] = "You are now signed in!"
      redirect_to user
    else
      @title = "Sign in"
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
