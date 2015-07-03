class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) # method returns ONLY parameters we want to allow
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!" # Only for 1 request
      redirect_to @user # user_url(@user)
    else
      render 'new'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
  
end
