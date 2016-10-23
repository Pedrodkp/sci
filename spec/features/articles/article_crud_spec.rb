require "spec_helper"
require 'rails_helper'

describe 'Article: ' do 
  it 'insert an article' do 
    insert_an_article
    expect(page).to have_content 'Artigo Teste 1 foi criado.'
  end

  it 'edit the article' do
    insert_an_article  
    edit_the_article
    expect(page).to have_content 'Artigo Teste 2 foi atualizado.'
  end      

  it 'see the history after edit the article' do
    insert_an_article
    edit_the_article
    click_link 'Histórico'
    click_link 'Ver'
    expect(page).to have_content 'Artigo Teste 1'
  end
end