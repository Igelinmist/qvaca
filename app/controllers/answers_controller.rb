class AnswersController < InheritedResources::Base
  respond_to :html, :js, :json
  belongs_to :question
  actions :all, except: [:new, :index]
  custom_actions resource: [:vote]

  before_action :authenticate_user!, only: [:create, :update, :destroy, :vote]

  def destroy
    destroy!(notice: 'Ваш ответ удален.') { parent_url }
  end


  def vote
    params[:type] == '+' ? resource.get_like(current_user) : resource.get_dislike(current_user)
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
