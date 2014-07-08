class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, meta: { timestamp: collection.last.created_at }
  end

  def show
    respond_with resource, except: :answers
  end

end