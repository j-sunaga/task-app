# frozen_string_literal: true

module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    if current_user.blank?
      flash[:danger] = 'ログインが必要です'
      render 'sessions/new'
    end
  end
end
