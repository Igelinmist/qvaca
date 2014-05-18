require 'spec_helper'

describe CommentsController do
  describe "POST #create" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }

    context "with valid attributes" do
      login_user

      it "assign the current user to comment" do
        post :create, comment: attributes_for(:comment), commentable_id: question, commentable_type: 'Question', question_id: question, format: :js
        expect(assigns(:comment).user).to eq @user
      end

      it "save new comment in dababase" do
        expect { post :create, comment: attributes_for(:comment), commentable_id: question, commentable_type: 'Question', question_id: question, format: :js }.to change(question.comments, :count).by(1)
      end

      it "render create template" do
        post :create, comment: attributes_for(:comment), commentable_id: question, commentable_type: 'Question', question_id: question, format: :js
        expect(response).to render_template :create 
      end      
    end

    context "with wrong attributes" do
      it "does not save the comment in dababase" do
        expect { post :create, comment: attributes_for(:invalid_comment), commentable_id: question, commentable_type: 'Question', question_id: question, format: :js }.to_not change(Comment, :count)
      end

      it "render create template" do
        post :create, comment: attributes_for(:invalid_comment), commentable_id: question, commentable_type: 'Question', question_id: question, format: :js
        expect(response).to render_template :create 
      end 
    end
  end

end
