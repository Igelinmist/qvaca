class AnswersController < ApplicationController
  before_filter :check_for_cancel, :only => [:create, :update]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
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

  private

  def answer_params
    params.require(:answer).permit(:question_id,:body)
  end

  def check_for_cancel
    if params[:commit] == 'Отмена'
      @question = Question.find(params[:question_id])
      render 'index'
    end
  end
end
