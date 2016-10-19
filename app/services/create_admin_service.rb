class CreateAdminService
  def call
    user = User.where(email: Rails.application.secrets.admin_email).first
    if user == nil
      user = User.new
      user.email = Rails.application.secrets.admin_email
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.name = Rails.application.secrets.admin_name  
      user.skip_confirmation!
      user.save    
    end
    return user
  end
end
