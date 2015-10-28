class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :require_login, except: [:index, :edit, :update, :destroy]

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "signup_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "flash.user.update.success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = t "flash.user.delete.success"
    else
      flash[:warning] = t "flash.user.delete.fail"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user?(@user)
  end

end
