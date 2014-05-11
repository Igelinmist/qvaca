require 'spec_helper'

describe AnswersController do
  describe "POST #create" do
    let(:question) { create :question }
    
    context 'with valid attributes' do
      it "save new answer in database" do
        expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(question.answers, :count).by(1)
      end

      it "redirect to question show view" do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to question_path(question)        
      end
    end

    context 'with wrong attributes' do
      it "does not save the answer in database" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.to_not change(Answer, :count)
      end

      it "redirect to question show view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to redirect_to question_path(question)        
      end
    end
  end


end
