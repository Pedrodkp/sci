class Taxonomy < ActiveRecord::Base
	validates :code, presence: true, uniqueness: true
  before_save      

	def self.search(search_by_text, search_by_kind, sort_column, sort_direction)
    f = self
    f = f.where("code like :search_by_text or description like :search_by_text", search_by_text: "%#{search_by_text}%") if search_by_text.present?
 		f = f.where("kind = :search_by_kind", search_by_kind: "#{search_by_kind}") if search_by_kind.present?
    f = f.order(sort_column + " " + sort_direction)  
 	end 	

 	belongs_to :user
 	has_many :relationships, :dependent => :delete_all
 	has_many :articles, :through => :relationships
end
