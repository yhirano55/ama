class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :set_raven_context, :set_request_variant, :set_page_meta_tags
  helper_method :current_user, :logged_in?, :default_meta_tags

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:danger] = t("#{policy_name}.#{exception.query}", scope: :pundit, default: :default)
      redirect_back fallback_location: root_path
    end

    def set_page_meta_tags
      @page_title = t(".title", default: "")
    end

    def current_user
      return unless session[:remember_token]
      return @current_user if defined?(@current_user)

      @current_user = User.with_attached_avatar.find_by(remember_token: session[:remember_token])
    rescue ActiveRecord::RecordNotFound
      reset_session
      nil
    end

    def logged_in?
      !current_user.nil?
    end

    def set_raven_context
      Raven.user_context(id: current_user&.id)
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def set_request_variant
      request.variant = request.device_variant
    end
end
