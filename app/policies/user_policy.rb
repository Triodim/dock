class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user.id == in_user.id
  end

  def create?
   true
  end

  def update?
    user.admin? || user.id == in_user.id
  end

  def destroy?
    user.admin? || user.id == in_user.id
  end

  private

  def in_user
    model
  end
end