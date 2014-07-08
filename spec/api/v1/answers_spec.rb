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
end