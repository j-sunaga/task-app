class UsersController < ApplicationController

  before_action :user_check, only: [:show,:edit,:update]
  before_action :user_find, only: [:show,:edit,:update]

  def new
    if current_user.blank?
      @user = User.new
    else
      flash[:danger] = '既に登録済みです'
      redirect_to tasks_path
    end
  end

  def create
    @user= User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      redirect_to user_path(@user), notice: "会員登録が完了しました。"
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  #アップデートアクション
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "会員情報を変更しました。"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def user_find
    @user= current_user
  end

  def user_check
    if session[:user_id] != params[:id].to_i
      flash[:danger] = '別のユーザ情報は確認できません'
      redirect_to tasks_path
    end
  end

end
