# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :logged_in?
  before_action :set_task, only: %i[show edit update destroy]

  def index
    if params[:search].present?
      @tasks = Task.filter(current_user, params[:name], params[:status], params[:label], params[:page])
    elsif params[:sort_expired]
      @tasks = current_user.tasks.page(params[:page]).deadline
    elsif params[:sort_priority]
      @tasks = current_user.tasks.page(params[:page]).priority
    elsif params[:label]
      @tasks = current_user.labels.find_by(name: params[:label]).tasks
    else
      @tasks = current_user.tasks.page(params[:page]).recent
    end
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'タスクの登録が完了しました'
    else
      render :new
    end
  end

  def update
    destroy_all_labels if params[:task][:label_ids].blank?
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクの更新が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_url, notice: 'タスクを削除しました'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :status, :user_id, label_ids: [])
  end

  def destroy_all_labels
    @task.labels.destroy_all
  end
end
