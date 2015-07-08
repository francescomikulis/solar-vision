class OptionalAdminController < ApplicationController
  def show
    @optional_admin = User.find(params[:id])
  end
  def edit
  end
  def index
    @optional_admin = User.paginate(page: params[:page])
  end
  def new
    #@user = User.new
  end
  def create
  end
  def update
  end
  def destroy
  end
end
