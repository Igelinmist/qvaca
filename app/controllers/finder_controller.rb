class FinderController < ApplicationController
  def search
    @result_all = ThinkingSphinx.search params[:inclusion]
    @result_question = Question.search params[:inclusion]
    @result_answer = Answer.search params[:inclusion]
    @result_comment = Comment.search params[:inclusion]
  end
end
