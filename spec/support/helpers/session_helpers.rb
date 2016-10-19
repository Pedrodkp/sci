module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Senha', with: password
      fill_in 'Confirmação de Senha', :with => confirmation
      click_button 'Me cadastrar'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      click_button 'Entrar'
    end

    def test_user
      user = User.where(email: "test@example.com").first
      if user == nil
        user = User.new
        user.email = "test@example.com"
        user.password = "please123"
        user.password_confirmation = "please123"
        user.name = "Test User"
        user.skip_confirmation!
        user.save    
      end
      return user      
    end
  end
end
