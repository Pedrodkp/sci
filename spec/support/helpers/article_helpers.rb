module Features
  module SessionHelpers
    def insert_an_article
      user = test_user
      signin(user.email, user.password)
      visit new_article_path
      fill_in('Título', :with => 'Artigo Teste 1')
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
