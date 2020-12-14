class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pets = ApplicationPet.find_by_app(@application.id)
    if @application.Pending? && @application.is_rejected?
      @application.approve
    elsif @application.Pending? && @application.is_approved?
      @application.reject
    end
  end
end