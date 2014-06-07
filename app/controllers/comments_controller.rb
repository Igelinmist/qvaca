class CommentsController < InheritedResources::Base
  respond_to :html, :js, :json
  belongs_to :question, :answer, polymorphic: true

  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create
    create! do |success, failure|
      success.json { render json: @comment }
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
    destroy! { redirect_to parent_url }
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def comment_params
    params.require(:comment).permit(:question_id, :body)
  end
end
