class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_user

  private

  def set_user
    if !current_user.nil?
      cookies[:user_id] = current_user.id
    end
  end
end
