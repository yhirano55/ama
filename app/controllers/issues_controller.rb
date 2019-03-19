class IssuesController < ApplicationController
  before_action :authorize_issue, only: [:index, :new, :create]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    relation = Issue.eager_load(user: { avatar_attachment: :blob })
    @issues = OrderedIssuesQuery.new(relation, params.slice(:sort)).all
  end

  def show
    @page_title = @issue.subject
    relation = @issue.comments.eager_load(:likes, user: { avatar_attachment: :blob })
    @comments = OrderedCommentsQuery.new(relation, params.slice(:sort)).all.page(params[:page]).per(100)
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = current_user.issues.new(issue_params)

    if @issue.save
      redirect_to @issue, flash: { success: t("flash.created", resource: @issue.model_name.human) }
    else
      render :new
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to @issue, flash: { success: t("flash.updated", resource: @issue.model_name.human) }
    else
      render :edit
    end
  end

  def destroy
    @issue.destroy!
    redirect_to issues_url, flash: { success: t("flash.destroyed", resource: Issue.model_name.human) }
  end

  private

    def authorize_issue
      authorize Issue
    end

    def set_issue
      @issue = Issue.eager_load(:likes).find(params[:id])
      authorize @issue
    end

    def issue_params
      params.require(:issue).permit(:subject, :description, :secret)
    end
end
