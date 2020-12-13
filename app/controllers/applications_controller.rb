class ApplicationsController < ApplicationController

def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @match_pets = Pet.search_by_name(params[:search])
    end
  end

  def new
  end
  
  def create
    app = Application.new(application_params)
    if app.save
      redirect_to application_path(app.id)
    else
      flash.now.notice = "Application not created. Required information is missing."
      render :new
    end
  end

  def edit
  end

  def update
    app = Application.find(params[:id])
    app.update({
                  description: params[:description],
                  status: 1
              })
    redirect_to application_path(app)
  end
  
  def destroy
  end

  private
  def application_params
    params.permit(:name, :street, :city, :state, :postal_code, :description)
  end
end