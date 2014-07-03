class Api::V1::ProfilesController < Api::V1::BaseController
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  respond_to :json
  actions :index
  
  def me
    respond_with current_resource_owner
  end

  def index
    respond_with collection.to_json(include: :profile)
  end

  protected

  def collection
    collection ||= User.all.includes :profile
  end
end