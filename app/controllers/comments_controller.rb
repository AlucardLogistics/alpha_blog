class CommentsController < ApplicationController
  
  before_action :find_article
  before_action :find_comment, only: [:destroy, :edit, :update, :require_same_user_comments]
  before_action :require_same_user_comments, only: [:destroy, :edit, :update]
  
  
  def create
    @comment = @article.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save
    
    if @comment.save
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def edit
    
  end
  
  
  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end
  
  private
  
  def find_article
    @article = Article.find(params[:article_id])
  end
  
  def find_comment
    @comment = @article.comments.find(params[:id])
  end
  
  def require_same_user_comments
      if current_user.id != @comment.user_id and !current_user.admin?
        flash[:danger] = "You do not have authorization to do that"
        redirect_to article_path(@article)
      end
    end
  
end
