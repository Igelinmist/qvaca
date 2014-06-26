class CommentsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :js, :json
  belongs_to :question, :answer, polymorphic: true

  def create
    create! do |success, failure|
      success.json do
        comment = resource.attributes
        comment[:profile_id] = resource.user.profile.id
        comment[:author_nick] =  resource.user.display_name
        render json: comment
      end
      failure.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    update! do |success, failure|
      success.json { render json: @comment }
      failure.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.json { render json: resource.id}
    end
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def comment_params
    params.require(:comment).permit(:question_id, :answer_id, :body)
  end
end
