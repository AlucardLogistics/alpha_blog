class ArticlesController < ApplicationController
  
  #use the method :set_article from private only on those methods before they do anything else 
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  #for the page with all the articles
  def index
    #new variable for all the articles
    @articles = Article.all
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
  
  #private function the gives the params needed to identify the article we want to edit or create
  private
    
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
     params.require(:article).permit(:title, :description)
    end
  
end