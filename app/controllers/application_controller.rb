class ApplicationController < ActionController::Base
  helper_method :guest_user, :logged_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def guest_user
    current_user == User.find_by(email: 'guest@example.com')
  end

  protected

  def logged_in?
    !!session[:user_id]
  end

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
