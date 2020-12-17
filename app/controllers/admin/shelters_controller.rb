class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_by_name
    @shelters_with_pending = Shelter.pending_applications
  end

  def show
    @shelter_details = Shelter.name_and_address(params[:id]).first
    @shelter = Shelter.find(params[:id])
  end
end