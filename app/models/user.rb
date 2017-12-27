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
    nome = self[:email].split("@")[0]    
    nome = nome.sub!("."," ") if nome.include? "."
    nome = nome.titleize
  end  
end
