class CommentsController < ApplicationController
  before_filter :setup_class
  
  def create
    @commentable = @commentable_class.find(@commentable_id)
    @comment = @commentable.comments.create(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

  def setup_class
    @commentable_class = params[:commentable_type].singularize.classify.constantize
    @commentable_id = params[:commentable_id]
  end
end
