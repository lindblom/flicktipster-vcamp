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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111126223252) do

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "youtube"
    t.string   "imdb"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.integer  "runtime"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
