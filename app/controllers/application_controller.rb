class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_user

  def after_sign_in_path_for(resource)
    if resource.admin?
      staff_reservations_path
    else
      root_path
    end
  end

  private

  def set_user
    return if current_user.nil?

    cookies[:user_id] = current_user.id
  end
end
