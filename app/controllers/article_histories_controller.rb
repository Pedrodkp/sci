class ArticleHistoriesController < ApplicationController
  before_action :set_article, only: [:show, :index]
  helper_method :sort_column, :sort_direction    
  before_action :authenticate_user!

  def show
    @articlehistory = ArticleHistory.find(params[:id])    
  end

  def index
    @articlehistories = @article.articlehistories.
                        select('article_histories.article_id, article_histories.id, article_histories.created_at, users.name').
                        joins(:user).
                        order(sort_column+' '+sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def article_params
      params.require(:article_history).permit(:article_id)
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end    

end
