class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]


  # GET /articles
  # GET /articles.json
  def index
    if params[:search]
      f = Article.search(params[:search])
    else
      f = Article.all
    end
    @articles = f.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new    
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
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

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
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

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: @article.title+t(:was_destroyed) }
      format.json { head :no_content }
    end
  end

  def like
    @article_like = ArticleLike.where(['article_id = ? AND user_id = ?', @article.id, current_user.id]).first
    if @article_like != nil
      @article_like.destroy
      msg = "Não gostou do artigo? Diga como podemos melhora-lo."
    else
      article_like = ArticleLike.create(article_id: @article.id, user_id: current_user.id)      
      msg = "Este artigo te ajudou, que bom!"
    end    
    redirect_to @article, notice: msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      @user = User.find(@article.user_id) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :attachments,
                                      :relationships_attributes => [:id, :article_id, :taxonomy_id, :_destroy, 
                                                                    :taxonomy_attributes => [:id, :code]])

      
    end

end
