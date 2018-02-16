class IssuePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    login_user? && admin_user?
  end

  def update?
    login_user? && admin_user?
  end

  def destroy?
    login_user? && admin_user?
  end
end
