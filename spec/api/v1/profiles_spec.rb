require 'spec_helper'

describe "Profiles API" do
  describe "Resource Owner Profile" do
    let(:api_path) { '/api/v1/profiles/me' }

    it_behaves_like "API Authenticable"

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
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path("user/#{attr}")
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
    let(:api_path) { '/api/v1/profiles' }

    it_behaves_like "API Authenticable"

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

      %w(id email).each do |attr|
        it "returns some user #{attr}" do
          expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path("profiles/1/#{attr}")
        end
      end

      %w(display_name real_name).each do |attr|
        it "returns some user's profile data #{attr}" do
          expect(response.body).to be_json_eql(user.profile.send(attr.to_sym).to_json).at_path("profiles/1/profile/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain some user #{attr}" do
          expect(response.body).to_not have_json_path("profiles/1/#{attr}")
        end
      end

    end
  end

  def do_request(options={  })
    get api_path, { format: :json }.merge(options)
  end
end
