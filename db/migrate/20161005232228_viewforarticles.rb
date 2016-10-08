class Viewforarticles < ActiveRecord::Migration
    def up
      self.connection.execute %Q( CREATE OR REPLACE VIEW view_articles AS
          SELECT articles.id
               , articles.title
               , articles.body
               , articles.created_at
               , articles.updated_at
               , articles.user_id 
               , (SELECT COUNT(*) FROM article_likes al WHERE al.article_id = articles.id) likes
            FROM articles;
      )
    end

    def down
      self.connection.execute "DROP VIEW IF EXISTS vw_articles;"
    end
end
