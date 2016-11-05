class AddTypeAndCorrelationsToTaxonomy < ActiveRecord::Migration
  def change
    add_column :taxonomies, :kind, :string
    add_column :taxonomies, :correlations, :string
  end
end
