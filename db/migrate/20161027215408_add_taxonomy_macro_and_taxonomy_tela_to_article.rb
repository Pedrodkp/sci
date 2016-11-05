class AddTaxonomyMacroAndTaxonomyTelaToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :taxonomy_macro_id, :integer
    add_foreign_key :articles, :taxonomies, column: :taxonomy_macro_id, primary_key: "id"
    add_column :articles, :taxonomy_tela_id, :integer        
    add_foreign_key :articles, :taxonomies, column: :taxonomy_tela_id, primary_key: "id"
  end
end
