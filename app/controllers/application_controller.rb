class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :store_return_to

  def after_sign_in_path_for(resource)
    session.delete(:return_to) || stored_location_for(resource) || root_path
  end

  private

  def store_return_to
    session[:return_to] = params[:return_to] if params[:return_to]
  end
end