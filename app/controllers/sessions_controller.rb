class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #storing the user id into the current session into a cookie
      session[:user_id] = user.id
      flash[:success] = "You have successfuly logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with the login information"
      render 'new'
    end
    #debugger
  end
  
  def destroy
    session[:user_id] = nil
    #flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end