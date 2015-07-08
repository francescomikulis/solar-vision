class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
   
  def create
    @user = User.new(user_params) # method accepts ONLY parameters we want to allow
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account." # Only for 1 request
      redirect_to root_url
    else
      errors = ["Password must MATCH Confirmation", "Password can't be BLANK"]
      flash.now[:danger] = errors.join("<br/>").html_safe
      render 'new'
    end
  end
  
 

  def edit
  end
  
  def update
    if (@user.update_attributes(user_params) &&
    (user_params[:password] == user_params[:password_confirmation]))
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      errors = ["Password must MATCH Confirmation", "Password can't be BLANK"]
      flash.now[:danger] = errors.join("<br/>").html_safe
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
    
    # Before filters.
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find_by(id: params[:id])
      if (!(current_user?(@user)) && !current_user.admin?)
        redirect_to(root_url)
      end
    end
    
    # Confirms that you are an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

