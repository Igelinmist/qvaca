class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :load_answer, only: [:update, :edit, :destroy, :vote]

  def index
    @question = Question.find(params[:question_id])
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @question = @answer.question
    @answer.update(answer_params)
  end

  def edit
    @question = @answer.question
  end

  def destroy
    question = answer.question
    answer.destroy
    flash[:notice] = 'Ваш ответ удален.'
    redirect_to question_path question
  end


  def vote
    params[:type] == '+' ? @answer.get_like(current_user) : @answer.get_dislike(current_user)
    respond_to do |format|
      format.js
    end
  end
  
  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:question_id, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
