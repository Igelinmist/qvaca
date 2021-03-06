require 'spec_helper'

describe "Questions API" do
  let(:api_path){ '/api/v1/questions' }
  it_behaves_like "API Authenticable"

  context 'authorized' do

    let!(:questions) { create_list(:question, 2) }
    let(:question) { questions.first }
    let!(:answer) { create(:answer, question: question) }
    let!(:access_token) { create(:access_token) }
    before do
      get '/api/v1/questions', format: :json, access_token: access_token.token
    end

    it 'returns 200 status code' do
      expect(response.status).to eq 200
    end

    it 'returns list of questions' do
      expect(response.body).to have_json_size(2).at_path('questions')
    end

    it "contains timestamp" do
      expect(response.body).to be_json_eql(questions.last.created_at.to_json).at_path("meta/timestamp")
    end

    %w(id title body created_at updated_at).each do |attr|
      it "question object contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
      end
    end

    context 'answers' do
      it 'included in question object' do
        expect(response.body).to have_json_size(1).at_path("questions/0/answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET question' do
    let!(:question) { create(:question) }
    let!(:comments) { create_pair(:comment, commentable: question) }
    let(:comment) { comments.first }
    let!(:attachments) { create_pair(:attachment, attachmentable: question) }
    let(:attachment) { attachments.first }
    let!(:answers) { create_pair(:answer, question: question) }

    context 'unauthorized' do
      it 'returns 401 status code if there is no access_token' do
        get "/api/v1/questions/#{question.id}", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      before do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      context 'comments' do
        it 'returns full list' do
          expect(response.body).to have_json_size(2).at_path('question/comments')
        end

        %w(id body created_at updated_at).each do |attr|
          it "object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("question/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'returns list' do
          expect(response.body).to have_json_size(2).at_path('question/attachments')
        end

        it "object contains url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("question/attachments/0/file/url")
        end

      end

      it 'not returns answers' do
        expect(response.body).to_not have_json_path('question/answers')
      end

    end
  end

  describe 'POST question' do
    context 'unauthorized' do
      it 'returns 401 status code if there is no access_token' do
        post "/api/v1/questions", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        post "/api/v1/questions", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'create valid question' do
        question = create(:question)
        post '/api/v1/questions',
          question: { title: question.title, body: question.body },
          access_token: access_token.token,
          format: :json

        %w(title body).each do |attr|
            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      context 'not create invalid question' do
        let(:question) { create(:question) }

        it 'have short title' do
          post '/api/v1/questions',
            question: { title: 'short', body: question.body },
            access_token: access_token.token,
            format: :json

          expect(response.body).to have_json_path('errors')
        end

        it 'have nil body' do
          post '/api/v1/questions',
            question: { title: question.title, body: nil },
            access_token: access_token.token,
            format: :json

          expect(response.body).to have_json_path('errors')
        end
      end
    end
  end

  def do_request(options={})
    get api_path, { format: :json }.merge(options)
  end
end
