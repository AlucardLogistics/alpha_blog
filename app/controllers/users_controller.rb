class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new 
    @user = User.new
  end
  
  def create
    #insert the user fields in the signup page
    @user = User.new(user_params)
    #if no errors while entering the :user fields 
    if @user.save
      flash[:success] = "Welcome to the Pet Story Site #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated succesfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  #private functions just for this class
  private
  
  #defines the params required for the :user obj so it can be saved for the db
  def user_params
    params.require(:user).permit(:username, :email, :password, :photo)
  end

end