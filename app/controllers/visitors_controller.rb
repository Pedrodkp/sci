class VisitorsController < ApplicationController
  def index
    @articles = Article.all
    @article_likes = ArticleLike.all
    @posts = Post.all
  end
end
