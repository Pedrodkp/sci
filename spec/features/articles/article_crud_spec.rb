require "spec_helper"
require 'rails_helper'

RSpec.feature 'Create article', :devise do 
  scenario 'User can create a article' do
    user = test_user
    signin(user.email, user.password)
    visit new_article_path
    fill_in('Título', :with => 'Artigo Teste')
    fill_in('Artigo', :with => 'teste texto do artigo')
    click_button 'Salvar'
    expect(page).to have_content 'Artigo Teste foi criado. '
  end  
end