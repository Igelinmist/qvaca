require 'spec_helper'

describe "Profiles API" do
  describe "Resource Owner Profile" do
    context 'unathorized' do
      it 'returns 401 status code if there is no access_token' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        get '/api/v1/profiles/me', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      before do
        get '/api/v1/profiles/me', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id email).each do |attr|
        it "returns user #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  describe "All profiles" do
    context 'unathorized' do
      it 'returns 401 status code if there is no access_token' do
        get '/api/v1/profiles', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token is invalid' do
        get '/api/v1/profiles', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:me) { create(:user) }
      let!(:user) { create(:user, display_name: 'BadBoy') }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      before do
        get '/api/v1/profiles', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id email created_at).each do |attr|
        it "returns some user #{attr}" do
          expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path("1/#{attr}")
        end
      end

      %w(display_name real_name).each do |attr|
        it "returns some user's profile data #{attr}" do
          expect(response.body).to be_json_eql(user.profile.send(attr.to_sym).to_json).at_path("1/profile/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain some user #{attr}" do
          expect(response.body).to_not have_json_path("1/#{attr}")
        end
      end

    end
  end
end
