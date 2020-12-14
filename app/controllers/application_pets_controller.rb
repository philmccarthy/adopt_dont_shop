class ApplicationPetsController < ApplicationController
  def create
    @app = Application.find(params[:app_id])
    @app_pet = ApplicationPet.new(application_id: @app.id, pet_id: params[:pet_id])
    if @app_pet.valid?
      @app_pet.save
    else
      flash[:notice] = "You already added that pet!"
    end
    redirect_to application_path(@app.id)
  end
end