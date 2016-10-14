class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction  

  def index
    @articles = ViewArticle.search(params[:search_by_text],
                                   params[:search_by_date_ini],
                                   params[:search_by_date_fim],
                                   sort_column,
                                   sort_direction
                                  ).paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def new
    @article = current_user.articles.build    
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id 
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: @article.title+t(:was_created) }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: @article.title+t(:was_updated) }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: @article.title+t(:was_destroyed) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      @LIKE_LEVELS = ['Ótimo','Bom','Razoavel','Ruim','Péssimo']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :attachments,
                                      :relationships_attributes => [:id, :article_id, :taxonomy_id, :_destroy, 
                                                                    :taxonomy_attributes => [:id, :code]])      
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end

end
