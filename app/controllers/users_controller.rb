class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)

  def new
    @user = User.new
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(@user.id)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id unless current_user
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    redirect_to tasks_path unless @user == current_user

    @near_limit = data_select.near_limit
    @time_over = data_select.time_over
  end

  def edit; end

  def update
    @user.update(user_params)

    if params[:remove_image]
      @user.avatar.purge
      @user.save
      render :edit
      return
    end

    if params[:return]
      redirect_to user_path(@user.id)
    elsif @user.save
      redirect_to user_path(@user.id), notice: "プロフィールを編集しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :profile, :admin, :password, :password_confirmation)
  end

  def data_select
    current_user.tasks.select(:id, :theme, :content, :priority, :status, :time_limit, :user_id, :created_at, :updated_at)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
