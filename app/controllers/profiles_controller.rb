class ProfilesController < InheritedResources::Base
  respond_to :html
  actions only: [:show]

  protected

  def resource
    @profile ||= end_of_association_chain.find(params[:id]).decorate
  end
  
end