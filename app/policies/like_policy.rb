class LikePolicy < ApplicationPolicy
  def create?
    login_user? && record.none? {|like| like.user_id == user.id }
  end

  def destroy?
    login_user? && record.any? {|like| like.user_id == user.id }
  end
end
