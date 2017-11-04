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

ActiveRecord::Schema.define(version: 20171102195752) do

  create_table "franchises", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",                         limit: 255
    t.integer  "year",                          limit: 4
    t.text     "synopsis",                      limit: 65535
    t.date     "release_date"
    t.integer  "franchise_id",                  limit: 4
    t.integer  "cinematographer_id",            limit: 4
    t.decimal  "imdb_rating",                                 precision: 10, scale: 2
    t.integer  "rotten_tomatoes_score",         limit: 4
    t.integer  "rotten_tomatoes_critics_score", limit: 4
    t.string   "quality",                       limit: 10
    t.decimal  "duration",                                    precision: 10, scale: 2
    t.string   "certification",                 limit: 5
    t.datetime "created_at",                                                                           null: false
    t.datetime "updated_at",                                                                           null: false
    t.string   "poster",                        limit: 255
    t.boolean  "info_updated",                                                         default: false
    t.string   "file_name",                     limit: 255
    t.string   "location",                      limit: 255
  end

  create_table "movies_genres", force: :cascade do |t|
    t.integer "movie_id", limit: 4
    t.integer "genre_id", limit: 4
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.string   "activity",   limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "user_name",              limit: 255
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
