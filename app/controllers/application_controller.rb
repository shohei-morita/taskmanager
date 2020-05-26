class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "guest_user", password: "guest_password"
end
