class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]

  def index
    if params[:search_by_text] or params[:search_by_date_ini] or params[:search_by_date_fim]
      #f = Article.search(params[:search_by_text],params[:search_by_date_ini],params[:search_by_date_fim])
      f = Article.select(:id, :title, :body, :created_at, :updated_at, :user_id).joins(:taxonomies)
      f = f.where("(   articles.title like :search_by_text 
                    or articles.body like :search_by_text 
                    or taxonomies.code like :search_by_text
                   )",search_by_text: "%#{params[:search_by_text]}%") if params[:search_by_text].present?
      f = f.where("DATE(articles.created_at) >= STR_TO_DATE(:search_by_date_ini,'%Y-%m-%d')",search_by_date_ini: "#{params[:search_by_date_ini]}") if params[:search_by_date_ini].present?
      f = f.where("DATE(articles.created_at) <= STR_TO_DATE(:search_by_date_fim,'%Y-%m-%d')",search_by_date_fim: "#{params[:search_by_date_fim]}") if params[:search_by_date_fim].present?
      f = f.group(:id, :title, :body, :created_at, :updated_at, :user_id)
    else
      f = Article.all
    end
    @articles = f.paginate(:page => params[:page], :per_page => 10)
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

end
