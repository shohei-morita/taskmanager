class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  before_action :authenticate_user, only: %i(index new show edit)

  def index
    @tasks = data_select.order(created_at: "DESC").page(params[:page]).per(10)
    @tasks = data_select.order(time_limit: "ASC").page(params[:page]).per(10) if params[:sort_expired].present?
    @tasks = data_select.order(priority: "DESC").page(params[:page]).per(10) if params[:sort_priority].present?

    if params[:search].present?
      if params[:theme].present? && params[:status].present? && params[:label_ids].present?
        @tasks = data_select.search_theme(params[:theme]).search_status(params[:status]).search_label(params[:label_ids]).page(params[:page]).per(10)

      elsif params[:theme].present? && params[:status].present? && params[:label_ids].blank?
        @tasks = data_select.search_theme(params[:theme]).search_status(params[:status]).page(params[:page]).per(10)

      elsif params[:theme].present? && params[:status].blank? && params[:label_ids].present?
        @tasks = data_select.search_theme(params[:theme]).search_label(params[:label_ids]).page(params[:page]).per(10)

      elsif params[:theme].blank? && params[:status].present? && params[:label_ids].present?
        @tasks = data_select.search_theme(params[:theme]).search_status(params[:status]).page(params[:page]).per(10)

      elsif params[:theme].present? && params[:status].blank? && params[:label_ids].blank?
        @tasks = data_select.search_theme(params[:theme]).page(params[:page]).per(10)

      elsif params[:theme].blank? && params[:status].present? && params[:label_ids].blank?
        @tasks = data_select.search_status(params[:status]).page(params[:page]).per(10)

      elsif params[:theme].blank? && params[:status].blank? && params[:label_ids].present?
        @tasks = data_select.search_label(params[:label_ids]).page(params[:page]).per(10)

      end
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if status_back
      render :new
    elsif @task.save
      redirect_to tasks_path, success: "タスクの登録が完了しました。"
    else
      render :new
    end
  end

  def show
    @task.read_unread = true
    @task.save
  end

  def edit
    label_data = @task.labels.all
    unless label_data.blank?
      @task.labels.build
    end
  end

  def update
    if status_back
      redirect_to tasks_path
    elsif @task.update(task_params)
      redirect_to tasks_path, success: "タスクの編集が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, danger: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:theme, :content, :priority, :status, :image, :time_limit, :read_unread, :user_id, label_ids:[])
  end

  def data_select
    current_user.tasks.select(:id, :theme, :content, :priority, :status, :time_limit, :read_unread, :user_id, :created_at, :updated_at)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def status_back
    params[:back]
  end
end
