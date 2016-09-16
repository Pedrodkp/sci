class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where("posts.title like ? or posts.content like ?","%#{query}%","%#{query}%")
  end 	

  belongs_to :user
end
