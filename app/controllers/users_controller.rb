class UsersController < ApplicationController
  def index
    authorize User
    @users = User.with_attached_avatar.newest.page(params[:page])
  end

  def show
    @user = User.with_attached_avatar.find(params[:id])
    authorize @user
    @page_title = @user.nickname
    relation = @user.comments.not_secret.eager_load(:issue, :likes, user: { avatar_attachment: :blob })
    @comments = OrderedCommentsQuery.new(relation, params.slice(:sort)).all.page(params[:page])
  end
end
