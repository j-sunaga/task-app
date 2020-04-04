class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:search].present? then
      if params[:name].present? && params[:status].present? then
        @tasks = Task.page(params[:page]).name_like(params[:name]).find_by(status: params[:status])
      elsif params[:name].blank? && params[:status].present? then
        @tasks = Task.page(params[:page]).find_by(status: params[:status])
      elsif params[:name].present? && params[:status].blank? then
        @tasks = Task.page(params[:page]).name_like(params[:name])
      else
        @tasks = Task.all.page(params[:page]).recent
      end
    elsif params[:sort_expired] then
      @tasks = Task.all.page(params[:page]).deadline
    elsif params[:sort_priority] then
      @tasks = Task.all.page(params[:page]).priority
    else
      @tasks = Task.all.page(params[:page]).recent
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
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクの更新が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'タスクを削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :status, :user_id)
  end

end
