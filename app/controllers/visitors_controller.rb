class VisitorsController < ApplicationController
  def index
    if user_signed_in?
      @articles = Article.all
      @article_likes = ArticleLike.all
      @posts = Post.all
    else
      redirect_to new_user_session_path
    end
  end
end
