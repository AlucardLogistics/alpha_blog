class UsersController < ApplicationController
  
  #adds a :set_user method to the edit update and show methods before anything else
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new 
    @user = User.new
  end
  
  def create
    #insert the user fields in the signup page
    @user = User.new(user_params)
    #if no errors while entering the :user fields 
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Pet Story Site #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
    
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated succesfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles of this user have been deleted"
    redirect_to users_path
  end
  
  #private functions just for this class
  private
  
  #defines the params required for the :user obj so it can be saved for the db
  def user_params
    params.require(:user).permit(:username, :email, :password, :photo)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You don't have authorization to do that"
      redirect_to root_path
    end  
  end
  
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin can do that"
      redirect_to root_path
    end
  end

end