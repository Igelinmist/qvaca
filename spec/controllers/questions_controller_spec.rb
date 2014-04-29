require 'spec_helper'

describe QuestionsController do
  describe 'Routing' do
    it {should route(:get, '/questions').to('questions#index')}
    it {should route(:get, '/questions/new').to('questions#new')}
    it {should route(:post, '/questions').to('questions#create')}
    it {should route(:get, '/questions/1').to(id: 1, controller: 'questions', action: 'show')}
    it {should route(:get, '/questions/1/edit').to(id: 1, controller: 'questions', action: 'edit')}
  end


end
