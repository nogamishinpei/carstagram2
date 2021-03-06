class ApplicationController < ActionController::Base
  # ログインしていないと他のページに行けないように
  before_action :authenticate_user!, except: [:top, :about]

  before_action :configure_parmitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    post_images_path
  end

  protected

  def configure_parmitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
