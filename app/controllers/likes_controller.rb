class LikesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  rescue_from ActionController::InvalidAuthenticityToken do
    head :bad_request
  end

  def create
    current_user.likes.find_or_create_by!(likeable_type: params[:resource_type], likeable_id: params[:resource_id])
    head :ok
  end

  def destroy
    current_user.likes.find_by!(likeable_type: params[:resource_type], likeable_id: params[:resource_id]).destroy!
    head :ok
  end
end
