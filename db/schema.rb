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

ActiveRecord::Schema.define(:version => 25) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "user_name"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
    t.string   "slug"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "counters", :force => true do |t|
    t.integer  "hit",        :default => 0
    t.string   "ip"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "photo"
    t.integer  "post_id"
    t.integer  "recipe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "logins", :force => true do |t|
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "account_id"
    t.boolean  "logged_in",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "remote"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "recipe_id"
    t.integer  "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.integer  "account_id"
    t.string   "slug"
  end

  create_table "recipes", :force => true do |t|
    t.string   "content"
    t.string   "main_ingredient"
    t.string   "course"
    t.integer  "post_id"
    t.integer  "image_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "prep_time"
    t.string   "cooking_time"
    t.string   "title"
    t.string   "image"
    t.string   "slug"
  end

  create_table "steps", :force => true do |t|
    t.integer  "recipe_id"
    t.string   "image"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "toppings", :force => true do |t|
    t.string   "title"
    t.string   "ingredients"
    t.string   "description"
    t.integer  "recipe_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "uploads", :force => true do |t|
    t.text     "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vieweds", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
