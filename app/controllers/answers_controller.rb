class AnswersController < ApplicationController

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

  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id,:body)
  end

end
