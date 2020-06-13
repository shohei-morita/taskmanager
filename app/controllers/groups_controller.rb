class GroupsController < ApplicationController
  before_action :authenticate_user, only: %i(index new show edit)
  before_action :set_group, only: %i(show edit update destroy)

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: "新規グループを登録しました"
    else
      render :new
    end
  end

  def edit; end

  def update
    if status_back
      redirect_to groups_path
    elsif @group.update(task_params)
      redirect_to groups_path, success: "グループの編集が完了しました"
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @group.destroy
    redirect_to groups_path, danger: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :user_id)
  end

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def status_back
    params[:back]
  end
end
