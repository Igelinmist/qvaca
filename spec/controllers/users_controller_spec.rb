require 'spec_helper'

describe UsersController do
  let(:user) {create(:user)}

  describe 'GET #new' do
    before {get :new}
    it 'assign a new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end
end
