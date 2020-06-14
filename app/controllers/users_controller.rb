class UsersController < ApplicationController
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
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to tasks_path unless @user == current_user
    
    @near_limit = data_select.near_limit
    @time_over = data_select.time_over
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def data_select
    current_user.tasks.select(:id, :theme, :content, :priority, :status, :time_limit, :user_id, :created_at, :updated_at)
  end
end
