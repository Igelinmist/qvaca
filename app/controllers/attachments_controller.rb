class AttachmentsController < InheritedResources::Base
  respond_to :html
  actions only: [:destroy]
  belongs_to :question, :answer, polimorphic: true
  before_filter :setup_question

  def destroy
    destroy! { redirect_to @question }
  end

  private

  def setup_class
    @question = parent.instance_name == 'question' ?  parent : parent.question
  end
end
