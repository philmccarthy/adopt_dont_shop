class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pets = ApplicationPet.find_by_app(@application.id)
  end
end