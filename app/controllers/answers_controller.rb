class AnswersController < InheritedResources::Base
  respond_to :html, :js, :json
  belongs_to :question
  actions :all, except: [:new]

  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def destroy
    destroy!(notice: 'Ваш ответ удален.') { parent_url }
  end


  def vote
    @answer = Answer.find(params[:id])
    params[:type] == '+' ? @answer.get_like(current_user) : @answer.get_dislike(current_user)
    respond_to do |format|
      format.js
    end
  end
  
  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def answer_params
    params.require(:answer).permit(:question_id, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
