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

ActiveRecord::Schema.define(:version => 20120725165358) do

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.string   "channel_type"
    t.string   "tags"
    t.string   "categories"
    t.string   "language"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "channels_videos", :id => false, :force => true do |t|
    t.integer "channel_id", :null => false
    t.integer "video_id",   :null => false
  end

  add_index "channels_videos", ["channel_id", "video_id"], :name => "index_channels_videos_on_channel_id_and_video_id", :unique => true

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.string   "feedtype"
    t.string   "queries"
    t.string   "options"
    t.string   "keywords"
    t.string   "tags"
    t.string   "categories"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "channel_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "fullname"
    t.string   "shortname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.boolean  "admin",                               :default => false
    t.boolean  "remember_me"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "provider"
    t.string   "yt_video_id"
    t.string   "thumbnail_url"
    t.boolean  "is_complete"
    t.string   "continue"
    t.string   "duration"
    t.text     "categories"
    t.text     "keywords"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
