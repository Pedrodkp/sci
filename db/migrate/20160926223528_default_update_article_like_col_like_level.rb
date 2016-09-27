class DefaultUpdateArticleLikeColLikeLevel < ActiveRecord::Migration
  def change
  	ArticleLike.where(like_level: nil).update_all("like_level = 'Ótimo'")
  end
end
