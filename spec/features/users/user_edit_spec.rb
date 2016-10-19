include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user changes email address' do
    user = test_user
    login_as(user, :scope => :user)
    visit edit_user_registration_path(user)
    fill_in 'Email', :with => 'newemail@example.com'
    fill_in 'Senha atual:', :with => user.password
    click_button 'Atualizar'
    txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  scenario "user cannot edit another user's profile", :me do
    me = test_user

    other = User.where(email: "other@example.com").first
    if other == nil
      other = User.new
      other.email = "other@example.com"
      other.password = "please123"
      other.password_confirmation = "please123"
      other.name = "Other User"
      other.skip_confirmation!
      other.save    
    end

    login_as(me, :scope => :user)
    visit edit_user_registration_path(other)
    expect(page).to have_content 'Editar usuário'
    expect(page).to have_field('Email', with: me.email)
  end

end
