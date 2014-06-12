class AnswersController < InheritedResources::Base
  respond_to :html, :js, :json
  belongs_to :question
  actions :all, except: [:new, :index]

  before_action :authenticate_user!, only: [:create, :update, :destroy, :vote]

  def destroy
    destroy!{flash[:success] = "Ваш ответ удален."; parent_url }
  end


  def vote
    @answer = Answer.find(params[:id])
    @answer.vote(current_user, params[:rate])
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
