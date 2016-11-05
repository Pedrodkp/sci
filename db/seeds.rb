# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'ADMIN USER: ' << user.email

taxonomies = Taxonomy.create(code: 'Comum', kind: 'Macro')
puts 'TAXONOMY: ' << taxonomies.code

taxonomy_macro_comum = Taxonomy.find_by_code('Comum')
if taxonomy_macro_comum != nil
  Article.where(taxonomy_macro_id: nil).update_all("taxonomy_macro_id = " + taxonomy_macro_comum.id.to_s)
end
puts 'taxonomy_macro_comum to article'