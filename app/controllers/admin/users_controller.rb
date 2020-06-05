class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :authenticate_user, only: %i(index new show edit)
  before_action :non_admin_user

  def index
    @users = User.select(:id, :name, :admin, :email, :created_at, :updated_at)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      redirect_to admin_users_path
    elsif @user.save
      redirect_to admin_users_path, success: "新規ユーザーを登録しました"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if params[:back]
      redirect_to admin_users_path
    elsif @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def non_admin_user
    redirect_to tasks_path, danger: "あなたは管理者ではありません" unless current_user.admin?
  end
end