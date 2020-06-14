class GroupUsersController < ApplicationController
  def index
    @group_users = GroupUser.all
  end

  def create
    group_user = current_user.group_users.create(group_id: params[:group_id])
    redirect_to groups_path(group_user.group.id), info: "#{group_user.group.group_name}に加入しました"
  end

  def destroy
    group_user = current_user.group_users.find_by(id: params[:id])
    if group_user.nil?
      redirect_to group_path
    elsif group_user.destroy
      redirect_to groups_path, danger: "#{group_user.group.group_name}から脱退しました"
    end
  end
end
