class User < ActiveRecord::Base
  enum role: [:internal, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable

  has_many :taxonomies
  has_many :articles
  has_many :articlelikes
  has_many :posts
  has_many :comments  

  def name
    if self[:email].present?
      nome = self[:email].split("@")[0]    
      nome = nome.sub!("."," ") if nome.include? "."
      nome = nome.titleize
    else
      self[:nome]
    end
  end  
end
