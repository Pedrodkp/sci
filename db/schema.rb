# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161014004850) do

  create_table "article_likes", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "comment",    limit: 65535
    t.text     "like_level", limit: 65535
  end

  add_index "article_likes", ["article_id", "user_id"], name: "index_article_likes_on_article_id_and_user_id", unique: true, using: :btree
  add_index "article_likes", ["article_id"], name: "index_article_likes_on_article_id", using: :btree
  add_index "article_likes", ["user_id"], name: "index_article_likes_on_user_id", using: :btree

  create_table "article_taxonomies", force: :cascade do |t|
    t.integer  "article_id",  limit: 4
    t.integer  "taxonomy_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "article_taxonomies", ["article_id"], name: "index_article_taxonomies_on_article_id", using: :btree
  add_index "article_taxonomies", ["taxonomy_id"], name: "index_article_taxonomies_on_taxonomy_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",                    limit: 255
    t.text     "body",                     limit: 4294967295
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "user_id",                  limit: 4
    t.string   "attachments_file_name",    limit: 255
    t.string   "attachments_content_type", limit: 255
    t.integer  "attachments_file_size",    limit: 4
    t.datetime "attachments_updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer "article_id",    limit: 4
    t.string  "style",         limit: 255
    t.binary  "file_contents", limit: 65535
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "data_fingerprint",  limit: 255
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "comment",    limit: 65535
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "flaggings", force: :cascade do |t|
    t.string   "flaggable_type", limit: 255
    t.integer  "flaggable_id",   limit: 4
    t.string   "flagger_type",   limit: 255
    t.integer  "flagger_id",     limit: 4
    t.string   "flag",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flaggings", ["flag", "flaggable_type", "flaggable_id"], name: "index_flaggings_on_flag_and_flaggable_type_and_flaggable_id", using: :btree
  add_index "flaggings", ["flag", "flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], name: "access_flag_flaggings", using: :btree
  add_index "flaggings", ["flaggable_type", "flaggable_id"], name: "index_flaggings_on_flaggable_type_and_flaggable_id", using: :btree
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], name: "access_flaggings", using: :btree

  create_table "makes", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "webmotors_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "models", force: :cascade do |t|
    t.integer  "make_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "article_id",  limit: 4
    t.integer  "taxonomy_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["article_id"], name: "index_relationships_on_article_id", using: :btree
  add_index "relationships", ["taxonomy_id"], name: "index_relationships_on_taxonomy_id", using: :btree

  create_table "taxonomies", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "taxonomies", ["user_id"], name: "index_taxonomies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "view_articles", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4,          default: 0, null: false
    t.string   "title",      limit: 255
    t.text     "body",       limit: 4294967295
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id",    limit: 4
    t.integer  "likes",      limit: 8
  end

  create_table "vw_article", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4,          default: 0, null: false
    t.string   "title",      limit: 255
    t.text     "body",       limit: 4294967295
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id",    limit: 4
    t.integer  "likes",      limit: 8
  end

  add_foreign_key "article_likes", "articles"
  add_foreign_key "article_likes", "users"
  add_foreign_key "article_taxonomies", "articles"
  add_foreign_key "article_taxonomies", "taxonomies"
  add_foreign_key "articles", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "relationships", "articles"
  add_foreign_key "relationships", "taxonomies"
  add_foreign_key "taxonomies", "users"
end
