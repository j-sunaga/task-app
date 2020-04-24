# frozen_string_literal: true

class LabelsController < ApplicationController
  before_action :logged_in?
  before_action :set_label, only: %i[show edit update destroy]

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
    # 同じ名前のラベルが存在しなければ保存を許可
    if current_user.labels.find_by(name: label_params[:name]).blank?
      if @label.save
        redirect_to @label, notice: 'ラベルの登録が完了しました'
      else
        flash[:danger] = '保存に失敗しました'
        render :new
      end
    else
      flash[:danger] = '保存に失敗しました。同じ名前のラベルがすでに存在します'
      render :new
    end
  end

  def update
    # 同じ名前のラベルが存在しなければ更新を許可
    if current_user.labels.where.not(id: @label.id).find_by(name: label_params[:name]).blank?
      if @label.update(label_params)
        redirect_to @label, notice: 'ラベルの更新が完了しました'
      else
        flash[:danger] = '更新に失敗しました'
        render :edit
      end
    else
      flash[:danger] = '更新に失敗しました。同じ名前のラベルがすでに存在します'
      render :edit
    end
  end

  def destroy
    @label.destroy!
    redirect_to labels_url, notice: 'ラベルを削除しました'
  end

  private

  def set_label
    @label = current_user.labels.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name, :user_id, task_ids: [])
  end

  def destroy_all_tasks
    @label.tasks.destroy_all
  end
end
