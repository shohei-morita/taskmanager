class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    elsif @task.save
      redirect_to tasks_path
      flash[:notice] = "タスクの登録が完了しました。"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if params[:back]
      redirect_to tasks_path
    elsif @task.update(task_params)
      redirect_to tasks_path
      flash[:notice] = "タスクの編集が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:danger] = "タスクを削除しました"
  end

  def confirm
    @task = Task.new(task_params)
    if params[:back]
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:theme, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
