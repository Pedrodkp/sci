class Article < ActiveRecord::Base
	validates :title, presence: true
 	validates :body, presence: true

	def self.search(search_by_text, search_by_date_ini, search_by_date_fim)
 	  joins(:taxonomies).
 	    where("(   articles.title like :search_by_text 
 	    	    or articles.body like :search_by_text 
 	    	    or taxonomies.code like :search_by_text
 	    	   ) 
 	    	   and (DATE(articles.created_at) >= STR_TO_DATE(:search_by_date_ini,'%Y-%m-%d') or :search_by_date_ini = '')
 	    	   and (DATE(articles.created_at) <= STR_TO_DATE(:search_by_date_fim,'%Y-%m-%d') or :search_by_date_fim = '')
 	    	   ",search_by_text: "%#{search_by_text}%",search_by_date_ini: "#{search_by_date_ini}",search_by_date_fim: "#{search_by_date_fim}").
 	      group(:id, :title, :body, :created_at, :updated_at, :user_id)
 	end 	

 	belongs_to :user
 	has_many :relationships, :dependent => :delete_all
 	has_many :taxonomies, :through => :relationships, :dependent => :delete_all
 	has_attached_file :attachments, :storage => :database
 	do_not_validate_attachment_file_type :attachments
 	#has_and_belongs_to_many :taxonomies
 	has_many :articlelikes

 	accepts_nested_attributes_for :relationships, reject_if: :all_blank, allow_destroy: true
end
