module Features
  module SessionHelpers
    def insert_an_taxonomy_macro 
      user = test_user
      signin(user.email, user.password)
      visit new_taxonomy_path
      fill_in('taxonomy[code]', :with => 'TAG Macro')
      select "Macro", :from => 'taxonomy[kind]'
      click_button 'Salvar'
    end
  end
end