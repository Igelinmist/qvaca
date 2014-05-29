class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_filter :setup_class, only: [:new, :create, :update, :index]
  before_filter :setup_comment, only: [:destroy, :edit]

  def index
    @comments = @commentable.comments
  end

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js 
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def new
    @comment = @commentable.comments.build
  end

  def edit
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
    end
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

  def setup_comment
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @question = if @comment.commentable_type == 'Question'
                  @commentable
                else
                  @commentable.question
                end
  end
end
