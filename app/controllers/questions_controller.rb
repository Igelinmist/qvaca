class QuestionsController < InheritedResources::Base
  respond_to :js
  custom_actions resource: [:vote]
  before_action :authenticate_user!, only: [:new, :create, :vote]
  before_action :set_author, only: [:create]

  def create
    create! notice: 'Ваш вопрос успешно размещен.'
  end

  def vote
    params[:type] == '+' ? resource.get_like(current_user) : resource.get_dislike(current_user)
  end

  protected

  def set_author
    build_resource.user = current_user
  end

  def question_params
    params.require(:question)
      .permit(:title, :body, :tag_names, attachments_attributes: [:id, :file, :_destroy])
  end
end
