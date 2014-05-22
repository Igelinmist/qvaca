class AttachmentsController < ApplicationController
  before_filter :setup_class

  def destroy
    attachment = Attachment.find(params[:id])
    @attachmentable.attachments.destroy attachment

    redirect_to @question
  end

  private

  def setup_class
    resource, attachmentable_id = request.path.split('/')[1, 2]
    attachmentable_class = resource.singularize.classify.constantize
    @attachmentable = attachmentable_class.find(attachmentable_id)
    @question = resource == 'questions' ?  @attachmentable : @attachmentable.question
  end
end
