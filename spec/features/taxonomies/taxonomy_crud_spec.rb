require "spec_helper"
require 'rails_helper'

describe 'Taxonomy: ' do 
  it 'insert an taxonomy' do 
    insert_an_taxonomy_macro
    expect(page).to have_content 'TAG Macro foi criado.'
  end
end