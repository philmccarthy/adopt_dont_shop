class Admin::ApplicationPetsController < ApplicationController
  def update
    @app_pet = ApplicationPet.find_by_keys(params[:app_id], params[:pet_id])
    if params[:status] == 'approve'
      @app_pet.approve
    else
      @app_pet.reject
    end
    redirect_to admin_application_path(params[:id])
  end
end