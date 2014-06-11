class ProfilesController < InheritedResources::Base
  respond_to :html
  actions only: [:show]
  
end