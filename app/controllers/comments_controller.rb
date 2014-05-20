class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_filter :setup_class, only: [:new, :create]
  before_filter :setup_question, only: [:destroy, :update]

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def new
    @comment = @commentable.comments.build
  end

  def destroy
    @comment.destroy
    redirect_to question_path @question
  end

  private

  def comment_params
    params.require(:comment).permit(:question_id, :body)
  end

  def setup_class
    resource, @commentable_id = request.path.split('/')[1, 2]
    @commentable_class = resource.singularize.classify.constantize
    @commentable = @commentable_class.find(@commentable_id)
    @question = resource == 'questions' ?  @commentable : @commentable.question
  end

  def setup_question
    @comment = Comment.find(params[:id])
    @question = if @comment.commentable_type == 'Question'
                  @comment.commentable
                else
                  @comment.commentable.question
                end
  end
end
