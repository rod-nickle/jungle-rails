class Admin::DashboardController < ApplicationController
  username = Rails.configuration.basic_auth[:username]
  password = Rails.configuration.basic_auth[:password]
  http_basic_authenticate_with name: username, password: password

  def show
  end
end
