class ApplicationController < ActionController::Base
  #http_basic_authenticate_with name: "guest_user", password: "guest_password"
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      redirect_to new_session_path, info: "ログインをする必要があります"
    end
  end
end
