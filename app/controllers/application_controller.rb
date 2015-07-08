class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include JsEnv
  before_action :set_locale
  helper_method :logged_in?, :current_user

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = cookies[:locale] || extract_locale_from_accept_language_header || 'en'
    cookies[:locale] = I18n.locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end

  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE']
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
end
