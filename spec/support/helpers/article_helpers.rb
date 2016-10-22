module Features
  module SessionHelpers
    def insert_an_article
      user = test_user
      signin(user.email, user.password)
      visit new_article_path
      fill_in('Título', :with => 'Artigo Teste')
      fill_in('Artigo', :with => 'teste texto do artigo')
      click_button 'Salvar'
    end
  end
end
