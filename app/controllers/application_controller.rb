class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # deviseコントローラーにストロングパラメータを追加
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    session[:url] #遷移元のURLへ移動
  end
  def after_sign_out_path_for(resource)
    info_path
  end

  # protected
  # def configure_permitted_parameters
  #   # サインアップ時のストロングパラメータを追加
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birth])
  #   # アカウント編集の時のストロングパラメータを追加
  # # devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  # end

end
