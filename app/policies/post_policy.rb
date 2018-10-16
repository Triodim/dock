class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    user_owner?
  end

  def destroy?
    user_owner?
  end

  private

  def user_owner?
    user.id == post.user_id
  end

  def post
    model
  end
end