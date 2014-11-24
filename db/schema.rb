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

ActiveRecord::Schema.define(version: 6) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: true do |t|
    t.string   "domain"
    t.text     "response"
    t.boolean  "can_use",    default: false
    t.boolean  "checked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: true do |t|
    t.string   "name"
    t.string   "image_path"
    t.string   "github_href"
    t.string   "zip_path"
    t.integer  "download_count",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "desc"
    t.integer  "view_count",                default: 0
    t.string   "source_type",               default: "html"
    t.string   "style_type",                default: "欧美"
    t.float    "file_length",    limit: 53, default: 0.0
    t.string   "come_form",                 default: "网络"
  end

end
