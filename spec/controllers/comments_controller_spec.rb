require 'spec_helper'

describe CommentsController do
  describe "POST #create" do
    let(:question) { create :question }

    context "with valid attributes" do
      it "save new comment in dababase" do
        expect { post :create, comment: attributes_for(:comment), commentable_id: question, commentable_type: 'Question',format: :js }.to change(question.comments, :count).by(1)
      end

      it "render create template" do
        post :create, comment: attributes_for(:comment), commentable_id: question, commentable_type: 'Question', format: :js
      end      
    end

    context "with wrong attributes" do
      it "does not save the comment in dababase" do
        expect { post :create, comment: attributes_for(:invalid_comment), commentable_id: question, commentable_type: 'Question', format: :js }.to_not change(Comment, :count)
      end

      it "render create template" do
        post :create, comment: attributes_for(:invalid_comment), commentable_id: question, commentable_type: 'Question', format: :js
      end 
    end
  end

end
