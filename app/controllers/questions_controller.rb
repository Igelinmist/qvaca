class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  
  def index
  	@questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
    @comment = @question.comments.build
  end

  def edit
    
  end

  def create
    @question = Question.create(question_params)
    @question.user = current_user
    if @question.save      
      flash[:notice] = 'Ваш вопрос успешно размещен.'
      redirect_to @question
    else
      
      render :new
    end
  end
  
  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title,:body)
  end

end

