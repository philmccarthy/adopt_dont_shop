class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pets = @application.application_pets
    if @application.Pending? && @application.is_rejected?
      @application.reject
    elsif @application.Pending? && @application.is_approved?
      @application.approve
      @application.make_pets_unadoptable
    end
  end
end