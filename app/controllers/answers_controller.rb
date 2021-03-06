class AnswersController < InheritedResources::Base
  before_action :authenticate_user!, only: [:create, :update, :destroy, :vote, :mark_the_best]
  load_and_authorize_resource
  respond_to :html, :js, :json
  belongs_to :question, optional: true
  actions :all, except: [:new, :index]

  def destroy
    destroy!{flash[:success] = "Ваш ответ удален."; parent_url }
  end

  def vote
    resource.vote(current_user, params[:rate])
  end

  def mark_the_best
    resource.make_the_best
    redirect_to resource.question
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
