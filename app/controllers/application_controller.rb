class ApplicationController < ActionController::Base
  #http_basic_authenticate_with name: "guest_user", password: "guest_password"
  add_flash_types :success, :info, :warning, :danger
end
