class SessionsController < ApplicationController
  def create
    create_session
    redirect_to root_or_origin_url, flash: { success: t("flash.logged_in") }
  end

  def destroy
    reset_session
    redirect_to root_path, flash: { success: t("flash.logged_out") }
  end

  private

    def user
      @user ||= User.find_or_initialize_by(uid: auth.dig(:uid)).tap do |u|
        u.nickname  = auth.dig(:info, :nickname)
        u.image_url = auth.dig(:info, :image)
        u.save!
      end
    end

    def create_session
      # ban check
      session[:remember_token] = user.remember_token
    end

    def auth
      request.env["omniauth.auth"]
    end

    def root_or_origin_url
      request.env["omniauth.origin"].presence || root_path
    end
end
