class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :invitaion_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def invitaion_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit :first_name, :last_name, :invitation_token
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :first_name, :last_name, :email, :password, :password_confirmation
    end
  end
end
