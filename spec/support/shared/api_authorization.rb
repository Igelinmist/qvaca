shared_examples_for "API Authenticable" do
  context 'aunauthorized' do
    it 'returns 401 status code if there is no access_token' do
      get '/api/v1/questions', format: :json
      expect(response.status).to eq 401
    end

    it 'returns 401 status code if access_token is invalid' do
      get '/api/v1/questions', format: :json, access_token: '1234'
      expect(response.status).to eq 401
    end
  end
end

