class ApplicationsController < ApplicationController

def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end
  
  def create
  end

  def edit
  end

  def update
  end
  
  def destroy
  end
end