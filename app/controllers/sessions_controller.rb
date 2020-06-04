class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user.id) if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      render :new, danger: "ログインに失敗しました"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, info: "ログアウトしました"
  end
end
