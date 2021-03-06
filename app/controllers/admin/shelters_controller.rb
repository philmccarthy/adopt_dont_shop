class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_by_name
    @shelters_with_pending = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.name_and_address(params[:id]).first
  end
end