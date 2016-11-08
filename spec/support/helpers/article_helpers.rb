module Features
  module SessionHelpers
    def insert_an_article
      insert_an_taxonomy_macro
      visit new_article_path
      fill_in('Título', :with => 'Artigo Teste 1')
      #puts page.body
      select "TAG Macro", :from => 'article[taxonomy_macro_id]'
      fill_in('Artigo', :with => 'teste texto do artigo')
      click_button 'Salvar'
    end

    def edit_the_article
      article = Article.where(title: 'Artigo Teste 1').first      
      visit edit_article_path(article.id)
      fill_in('Título', :with => 'Artigo Teste 2')
      fill_in('Artigo', :with => 'teste de mudança do texto do artigo')
      click_button 'Salvar'      
    end
  end
end
