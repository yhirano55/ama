class CommentsController < ApplicationController
  before_action :authorize_comment, only: [:index, :new, :create]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    relation = Comment.eager_load(:issue, :likes, user: { avatar_attachment: :blob })
    @comments = OrderedCommentsQuery.new(relation, params.slice(:sort)).all.page(params[:page])
  end

  def show
    @page_title = @comment.content
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to @comment.issue, flash: { success: t("flash.created", resource: @comment.model_name.human) }
    else
      render "comments/new"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.issue, flash: { success: t("flash.updated", resource: @comment.model_name.human) }
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy!
    redirect_to @comment.issue, flash: { success: t("flash.destroyed", resource: Comment.model_name.human) }
  end

  private

    def authorize_comment
      authorize Comment
    end

    def set_comment
      @comment = Comment.find(params[:id])
      authorize @comment
    end

    def comment_params
      params.require(:comment).permit(:issue_id, :content, :secret)
    end
end
