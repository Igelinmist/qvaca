class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:new, :create, :vote]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id ,:session_hash]
  load_and_authorize_resource
  skip_load_and_authorize_resource only: :index
  respond_to :js
  custom_actions resource: [:vote]
  before_action :set_author, only: [:create]

  def create
    create! notice: 'Ваш вопрос успешно размещен.'
  end

  def vote
    resource.vote(current_user, params[:rate])
  end

  protected

  def collection
    @questions ||= end_of_association_chain.paginate(:page => params[:page], :per_page => 10)
  end

  def set_author
    build_resource.user = current_user
  end

  def question_params
    params.require(:question)
      .permit(:title, :body, :tag_names, attachments_attributes: [:id, :file, :_destroy])
  end
end
