class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def create
    
    @article = Article.new(article_params)
    
    if @article.save
      #render plain: params[:article].inspect
      #flash[:notice] to create an informational message for the user 
      #it will be displayed on every page using the html wrapper in views/layouts/application.html.erb
      flash[:notice] = "Article was succesfully created."
      redirect_to article_path(@article)
    else
      #renders a new article.new page
      render 'new'
    end
    
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end