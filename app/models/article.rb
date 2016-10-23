class Article < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true
 	validates :body, presence: true

 	belongs_to :user

 	has_many :relationships, :dependent => :delete_all
 	has_many :taxonomies, :through => :relationships, :dependent => :delete_all

 	has_attached_file :attachments, :storage => :database
 	do_not_validate_attachment_file_type :attachments

 	has_many :articlelikes, :class_name => 'ArticleLike'
  has_many :articlehistories, :class_name => 'ArticleHistory'

 	accepts_nested_attributes_for :relationships, :articlelikes, reject_if: :all_blank, allow_destroy: true
end
