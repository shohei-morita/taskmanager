class LabelsController < ApplicationController
  before_action :authenticate_user, only: %i(index new show edit)
  before_action :set_label, only: %i(show edit update destroy)

  def index
    @labels = current_user.labels.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, success: "ラベルを追加しました"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if status_back
      redirect_to tasks_path
    elsif @label.update(label_params)
      redirect_to labels_path, success: "ラベルの編集が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, danger: "ラベルを削除しました"
  end

  private

  def label_params
    params.require(:label).permit(:label, :user_id, tasi_ids:[])
  end

  def set_label
    @label = current_user.labels.find(params[:id])
  end

  def status_back
    params[:back]
  end

end
