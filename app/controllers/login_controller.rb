class LoginController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.password == Digest::MD5.hexdigest(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to users_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
