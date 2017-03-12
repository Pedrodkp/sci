class Article < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true
 	validates :body, presence: true
  validate :taxonomy_tela_code_is_valid, on: [:create, :update]

  def taxonomy_tela_code_is_valid
    if (self.taxonomy_tela_id != nil) 
      if (self.taxonomy_tela_id == -1)
        errors.add(:taxonomy_tela_code, "não existe.")
      elsif !Taxonomy.find(self.taxonomy_tela_id).code.include?(Taxonomy.find(self.taxonomy_macro_id).code)
        errors.add(:taxonomy_tela_code, "não pertence a TAG macro.")
      end
    end
  end

 	belongs_to :user

 	has_many :relationships, :dependent => :delete_all
 	has_many :taxonomies, :through => :relationships, :dependent => :delete_all

 	has_attached_file :attachments, :storage => :database
 	do_not_validate_attachment_file_type :attachments

 	has_many :articlelikes, :class_name => 'ArticleLike'
  has_many :articlehistories, :class_name => 'ArticleHistory'

 	accepts_nested_attributes_for :relationships, :articlelikes, reject_if: :all_blank, allow_destroy: true

  def taxonomy_macro
    if self.taxonomy_macro_id != nil
      Taxonomy.find(self.taxonomy_macro_id)
    else
      nil
    end
  end

  def taxonomy_tela
    if self.taxonomy_tela_id != nil
      Taxonomy.find(self.taxonomy_tela_id)
    else
      nil
    end
  end

  def taxonomy_tela_code=(code) 
    if code.present?
      taxonomy_tela = Taxonomy.find_by_code(code) 
      if taxonomy_tela == nil
        self.taxonomy_tela_id = -1
      else
        self.taxonomy_tela_id = taxonomy_tela.id
      end
    else
      self.taxonomy_tela_id = nil
    end
  end

  def taxonomy_tela_code 
    if self.taxonomy_tela_id != nil && self.taxonomy_tela_id != -1
      Taxonomy.find(self.taxonomy_tela_id).code
    end 
  end
end