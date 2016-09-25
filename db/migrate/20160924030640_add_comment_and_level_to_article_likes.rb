class AddCommentAndLevelToArticleLikes < ActiveRecord::Migration
  def change
    add_column :article_likes, :comment, :text     
    add_column :article_likes, :like_level, :text
  end
end
