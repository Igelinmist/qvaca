class CommentsController < ApplicationController
  before_filter :setup_class
  
  def create
    @commentable = @commentable_class.find(@commentable_id)
    @comment = @commentable.comments.create(comment_params)
    @question = Question.find(params[:question_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :question_id, :body)
  end

  def setup_class
    @commentable_id = params[:commentable_id]
    @commentable_class = params[:commentable_type].classify.constantize
  end
end
