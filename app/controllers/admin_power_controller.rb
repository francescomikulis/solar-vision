class AdminPowerController < ApplicationController
  before_action :admin_user
  
  def list
    @admin_power = User.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find_by(id: params[:format])
    redirect_to edit_user_url(@user)
  end
  
  def makeAdmin
    @user = User.find_by(id: params[:format])
    @user.toggle(:admin)
    if @user.save
      message = "User "
      message += @user.name
      message += " successfully became an ADMIN"
      flash[:success] = message
      redirect_to admin_tools_url
    else
      flash[:warning] = "User failed to become an ADMIN"
      redirect_to admin_tools_url
    end
  end
  
  def delAdmin
    @user = User.find_by(id: params[:format])
    @user.toggle(:admin)
    if @user.save
      message = "User "
      message += @user.name
      message += " successfully lost ADMIN privileges"
      flash[:success] = message
      redirect_to admin_tools_url
    else
      flash[:warning] = "User failed to lose ADMIN privileges"
      redirect_to admin_tools_url
    end
  end
  
  def admin
    params[:confirmation]
  end
  
  def cleanup
    @users = User.all
    @users.each do |totaluser|
      if (totaluser.activation_email_sent < 2.hours.ago) && (!totaluser.activated?)
        destroy(totaluser.id)
      end
    end
  end
  
  def destroy(id)
    User.find(id).destroy
    flash[:success] = "Users were deleted"
    redirect_to admin_tools_url
  end
  
  private
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
