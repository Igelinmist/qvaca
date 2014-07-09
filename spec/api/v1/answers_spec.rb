require 'spec_helper.rb'

describe 'Answers API' do
  describe 'GET index' do
    context 'unauthorized' do
      it 'returns 401 status code if there is no access_token' do
        get '/api/v1/questions/1/answers', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        get '/api/v1/questions/1/answers', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:question) { create(:question) }
      let!(:answers) { create_pair(:answer, question: question) }
      let(:answer) { answers.first }
      let!(:access_token) { create(:access_token) }

      before do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2).at_path('answers')
      end

      it "contains timestamp" do
        expect(response.body).to be_json_eql(answers.last.created_at.to_json).at_path("meta/timestamp")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET show' do
    context 'unauthorized' do
      it 'returns 401 status code if there is no access_token' do
        get '/api/v1/questions/1/answers/1', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        get '/api/v1/questions/1/answers/1', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:question) { create(:question) }
      let!(:answer) { create(:answer, question: question) }
      let!(:comments) { create_pair(:comment, commentable: answer) }
      let(:comment) { comments.first }
      let!(:attachments) { create_pair(:attachment, attachmentable: answer) }
      let(:attachment) { attachments.first }
      let!(:access_token) { create(:access_token) }

      before do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      it 'returns list of comments' do
        expect(response.body).to have_json_size(2).at_path('answer/comments')
      end

      %w(id body created_at updated_at).each do |attr|
        it "comment object contains #{attr}" do
          expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
        end
      end

      it 'returns list of attachments' do
        expect(response.body).to have_json_size(2).at_path('answer/attachments')
      end

      %w(id created_at updated_at).each do |attr|
        it "attachment object contains #{attr}" do
          expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("answer/attachments/0/#{attr}")
        end
      end

      it 'attachment object contains file url' do
        expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path('answer/attachments/0/file/url')
      end
    end
  end

  describe 'POST answer' do
    context 'unauthorized' do
      it 'returns 401 status code if there is no access_token' do
        post '/api/v1/questions/1/answers', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        post '/api/v1/questions/1/answers', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:question) { create(:question) }

      it 'create valid answer' do
        answer = create(:answer, question: question)
        post "/api/v1/questions/#{question.id}/answers",
          answer: { body: question.body },
          access_token: access_token.token,
          format: :json

        expect(response.body).to be_json_eql(question.body.to_json).at_path("answer/body")
      end

      it 'have nil body' do
        post "/api/v1/questions/#{question.id}/answers",
          answer: { body: nil },
          access_token: access_token.token,
          format: :json
        
        expect(response.body).to have_json_path('errors')
      end
    end
  end
end
