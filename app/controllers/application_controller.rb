class ApplicationController < ActionController::Base
  def verify_post_user
    if current_user.blank?
      render json: {msg: "没有权限！"}, status: 422
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
