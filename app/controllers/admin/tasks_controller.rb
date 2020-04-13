class Admin::TasksController < ApplicationController

  before_action :logged_in?
  before_action :set_tasks

  def index
    @tasks.recent
  end

  private

  def set_tasks
    @tasks = User.find(params[:format]).tasks
  end

end
