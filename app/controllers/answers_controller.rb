class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

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
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.update(answer_params)
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def destroy
    answer = Answer.find(params[:id])
    question = answer.question
    answer.destroy
    flash[:notice] = 'Ваш ответ удален.'
    redirect_to question_path question
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end
end
