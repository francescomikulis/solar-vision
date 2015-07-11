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
      @user.update_attributes(activation_email_sent: Time.zone.now)
      flash[:info] = "Please check your email to activate your account.
        If you do not activate it with the link within 2 hours, it will expire." # Only for 1 request
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
    if @user.update_attributes(user_params) && accept_password
      if (blank_password)
        @user.update_attributes(update_no_pass_params)
      end
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      errors = ["Password must MATCH Confirmation"]
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
  
    def accept_password
      params[:password] == params[:password_confirmation]
    end
    
    def blank_password
      ((params[:password] == params[:password_confirmation]) == '')
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
    
    def update_no_pass_params
      params.require(:user).permit(:name, :email)
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

