class ViewArticle < ActiveRecord::Base
  def self.search(search_by_text, search_by_date_ini, search_by_date_fim, sort_column, sort_direction)
    f = select("view_articles.id, view_articles.title, view_articles.body, view_articles.created_at, view_articles.updated_at, view_articles.user_id, view_articles.likes")
    f = f.joins(" LEFT OUTER JOIN relationships r ON r.article_id = view_articles.id LEFT OUTER JOIN taxonomies t ON t.id = r.taxonomy_id")
    #Entendendo a linha abaixo:
    #  1) ['view_articles.title LIKE ? OR view_articles.body LIKE ? OR t.code LIKE ?'] * ==> multiplique este texto N vezes
    #  2) params[:search_by_text].split(';').length)                           ==> N é tamanho do array feito por split do paramatro por ;
    #  3) .join(' OR ')]                                                       ==> .join(' OR ') cria no array gerado uma posição entre cada duas com o texto OR
    #  4) +                                                                    ==> montou o SQL, repetindo quantos texto separados por ; vieram, agora começa os parametros
    #  5) params[:search_by_text].split(';').map { |name| "%#{name}%" }        ==> faz o MAP dos textos separados por ; para usar como parametro do SQL gerado
    #  6) * 3)                                                                 ==> multiplica cada Pos do MAP por 3 pois o SQL usa o mesmo texto para LIKE em 3 tabelas
    #  7) if params[:search_by_text].present?                                  ==> só executa a linha se o parametro estiver com valor
    f = f.where([(['view_articles.title LIKE ? collate utf8_general_ci OR view_articles.body LIKE ? collate utf8_general_ci OR t.code LIKE ? collate utf8_general_ci'] * 
                search_by_text.split(';').length).join(' OR ')] + 
                search_by_text.split(';').map { |name| "%#{name}%" } * 3) if search_by_text.present?
    f = f.where("DATE(view_articles.created_at) >= STR_TO_DATE(:search_by_date_ini,'%Y-%m-%d')",search_by_date_ini: "#{search_by_date_ini}") if search_by_date_ini.present?
    f = f.where("DATE(view_articles.created_at) <= STR_TO_DATE(:search_by_date_fim,'%Y-%m-%d')",search_by_date_fim: "#{search_by_date_fim}") if search_by_date_fim.present?
    f = f.group("view_articles.id, view_articles.title, view_articles.body, view_articles.created_at, view_articles.updated_at, view_articles.user_id")
    f = f.order(sort_column + " " + sort_direction)    
  end
end