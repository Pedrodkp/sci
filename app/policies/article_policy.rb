class ArticlePolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
