class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, meta: { timestamp: collection.last.created_at }
  end

  def show
    respond_with resource, except: :answers
  end

  protected

  def create_resource(object)
    object.user = current_resource_owner
    super
  end

  def question_params
    params.require(:question)
      .permit(:title, :body)
  end

end