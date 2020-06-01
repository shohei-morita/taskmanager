class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.order(created_at: "DESC").page(params[:page]).per(10)
    @tasks = Task.all.order(time_limit: "ASC").page(params[:page]).per(10) if params[:sort_expired].present?
    @tasks = Task.all.order(priority: "DESC").page(params[:page]).per(10) if params[:sort_priority].present?

    if params[:search].present?
      if params[:theme].present? && params[:status].present?
        @tasks = Task.search_theme(params[:theme]).search_status(params[:status]).page(params[:page]).per(10)
      elsif params[:theme].present? && params[:status].blank?
        @tasks = Task.search_theme(params[:theme]).page(params[:page]).per(10)
      elsif params[:theme].blank? && params[:status].present?
        @tasks = Task.search_status(params[:status]).page(params[:page]).per(10)
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

  def show; end

  def edit; end

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

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid? || status_back
  end

  private
  def task_params
    params.require(:task).permit(:theme, :content, :priority, :status, :time_limit)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def status_back
    params[:back]
  end

end
