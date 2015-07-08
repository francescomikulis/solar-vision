class AdminPowerController < ApplicationController
  
  def setup
    @user = User.find_by(id: '1')
    @id = '1'
  end
  
  def list
    @admin_power = User.paginate(page: params[:page])
  end
  
  def edit ()
    #@user = user
    @user = User.find_by(id: '1')
  end
  
end
