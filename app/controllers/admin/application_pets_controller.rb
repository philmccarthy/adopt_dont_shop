class Admin::ApplicationPetsController < ApplicationController
  def update
    @app_pet = ApplicationPet.find_by_keys(params[:app_id], params[:pet_id])
    if params[:status] == 'approve'
      @app_pet.approve
    else
      @app_pet.reject
    end

    if @app_pet.application.Pending? && @app_pet.application.is_rejected?
      @app_pet.application.reject
    elsif @app_pet.application.Pending? && @app_pet.application.is_approved?
      @app_pet.application.approve
      @app_pet.application.make_pets_unadoptable
    end

    redirect_to admin_application_path(params[:id])
  end
end