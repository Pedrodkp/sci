require "spec_helper"
require 'rails_helper'

describe 'Article: ' do 
  #scenario 'User can operate an article' do
    it 'insert an article' do 
      insert_an_article
      expect(page).to have_content 'Artigo Teste foi criado. '   
    end

    it 'change an article' do
      insert_an_article  
      article = Article.where(title: 'Artigo Teste').first
      visit edit_article_path(article.id)
      fill_in('Artigo', :with => 'teste de mudança do texto do artigo')
      click_button 'Salvar'
      expect(page).to have_content 'Artigo Teste foi atualizado.'
    end      
  #end 
end