class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]

  def index
    if params[:search_by_text] or params[:search_by_date_ini] or params[:search_by_date_fim]
      f = Article.select("articles.id, articles.title, articles.body, articles.created_at, articles.updated_at, articles.user_id")
      f = f.joins(" LEFT OUTER JOIN relationships r ON r.article_id = articles.id LEFT OUTER JOIN taxonomies t ON t.id = r.taxonomy_id")
      #Entendendo a linha abaixo:
      #  1) ['articles.title LIKE ? OR articles.body LIKE ? OR t.code LIKE ?'] * ==> multiplique este texto N vezes
      #  2) params[:search_by_text].split(';').length)                           ==> N é tamanho do array feito por split do paramatro por ;
      #  3) .join(' OR ')]                                                       ==> .join(' OR ') cria no array gerado uma posição entre cada duas com o texto OR
      #  4) +                                                                    ==> montou o SQL, repetindo quantos texto separados por ; vieram, agora começa os parametros
      #  5) params[:search_by_text].split(';').map { |name| "%#{name}%" }        ==> faz o MAP dos textos separados por ; para usar como parametro do SQL gerado
      #  6) * 3)                                                                 ==> multiplica cada Pos do MAP por 3 pois o SQL usa o mesmo texto para LIKE em 3 tabelas
      #  7) if params[:search_by_text].present?                                  ==> só executa a linha se o parametro estiver com valor
      f = f.where([(['articles.title LIKE ? OR articles.body LIKE ? OR t.code LIKE ?'] * params[:search_by_text].split(';').length).join(' OR ')] + 
                  params[:search_by_text].split(';').map { |name| "%#{name}%" } * 3) if params[:search_by_text].present?
      f = f.where("DATE(articles.created_at) >= STR_TO_DATE(:search_by_date_ini,'%Y-%m-%d')",search_by_date_ini: "#{params[:search_by_date_ini]}") if params[:search_by_date_ini].present?
      f = f.where("DATE(articles.created_at) <= STR_TO_DATE(:search_by_date_fim,'%Y-%m-%d')",search_by_date_fim: "#{params[:search_by_date_fim]}") if params[:search_by_date_fim].present?
      f = f.group("articles.id, articles.title, articles.body, articles.created_at, articles.updated_at, articles.user_id")
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
