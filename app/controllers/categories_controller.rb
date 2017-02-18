class CategoriesController < ApplicationController
  
  before_action :require_admin, except: [:index, :show]
  
  #each def variable will be accesible from the view with the same name!!!
  #@category from def new will not be visible in show!!! 
  #it has to be defined in show too to be visible in the show view
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created succesfully"
      redirect_to categories_path
    else 
      render 'new'
    end
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 8)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
  
end