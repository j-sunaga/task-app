class Admin::UsersController < ApplicationController

  before_action :logged_in?
  before_action :admin_check
  before_action :user_find, only: [:show,:edit,:update,:destroy]

  def index
    if params[:name].present?
      @users = User.page(params[:page]).name_like(params[:name])
    elsif params[:name_order]
      @users = User.page(params[:page]).name_order
    else
      @users = User.all.page(params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "会員登録が完了しました。"
    else
      render 'new'
    end
  end

  def show
    @tasks=@user.tasks.recent
  end

  def edit; end

  #アップデートアクション
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "会員情報を変更しました。"
    else
      flash[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
   if @user.destroy
    redirect_to admin_users_path, notice: 'ユーザを削除しました'
   else
    flash[:danger] = '削除に失敗しました'
    redirect_to admin_users_path
   end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:admin,:password,:password_confirmation)
  end

  def user_find
    @user= User.find(params[:id])
  end

  def admin_check
    if current_user.admin != true
      flash[:danger] = '権限がありません'
      redirect_to tasks_path
    end
  end

end
