class LabelsController < ApplicationController

  before_action :logged_in?
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = current_user.labels
  end

  def show; end

  def new
    @label = Label.new
  end

  def edit; end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to @label, notice: 'ラベルの登録が完了しました'
    else
      render :new
    end
  end

  def update
    if @label.update(label_params)
      redirect_to @label, notice: 'ラベルの更新が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_url, notice: 'ラベルを削除しました'
  end

  private

  def set_label
    @label = current_user.labels.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name,:user_id,task_ids: [])
  end

end
