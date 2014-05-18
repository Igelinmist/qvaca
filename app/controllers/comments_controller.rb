class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_filter :setup_class
  
  def create
    @comment = @commentable.comments.create(user: current_user)
    if @comment.save
      flash[:notice] = 'Комментарий успешно добавлен.'
      render 'index.js'
    else
      flash[:notice] = 'Ошибка при добавлении комментария'
      redirect_to question_path @question
    end
  end

  def new
    @comment = @commentable.comments.build
  end

  private

  def comment_params
    params.require(:comment).permit(:question_id, :body)
  end

  def setup_class
    @resource,@commentable_id = request.path.split('/')[1,2]
    @commentable_class = @resource.singularize.classify.constantize
    @commentable = @commentable_class.find(@commentable_id)
    @resource =='questions' ? @question = @commentable : @question = @commentable.question
  end
end
