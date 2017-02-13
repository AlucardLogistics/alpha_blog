class ArticlesController < ApplicationController
  
  #use the method :set_article from private only on those methods before they do anything else 
  # they always execute in order
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  #this is to prevent someone to access edit articles if he's not logged in like from url
  before_action :require_user, except: [:index, :show]
  #prevent user to modify other users articles
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  #for the page with all the articles
  def index
    #new variable for all the articles
    @articles = Article.paginate(page: params[:page], per_page: 6)
  end
  
  #create new article
  def new
    @article = Article.new
  end
  
  #edit existing article
  def edit
    #@article = Article.find(params[:id])
  end
  
  #create the new article and saving it to the db
  def create
    
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      #render plain: params[:article].inspect
      #flash[:notice] to create an informational message for the user 
      #it will be displayed on every page using the html wrapper in views/layouts/application.html.erb
      flash[:success] = "Article was succesfully created."
      redirect_to article_path(@article)
    else
      #renders a new article.new page
      render 'new'
    end
    
  end
  
  #update the existing article from edit and save it to the db
  def update
    #@article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Articlae succesfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  #show the current article on the web app
  def show
    #@article = Article.find(params[:id])
  end
  
  #deletes the current article
  def destroy
    #@article = Article.find(params[:id])
    @article.destroy
    
    
    redirect_to articles_path
    flash[:danger] = "Article was deleted."
  end
  
  
  private
    
    def set_article
      @article = Article.find(params[:id])
    end
    #private function the gives the params needed to identify the article we want to edit or create
    def article_params
     params.require(:article).permit(:title, :description)
    end
    
    #prevent user to modify other users articles
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You do not have authorization to do that"
        redirect_to root_path
      end
    end
  
end