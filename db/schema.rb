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

ActiveRecord::Schema.define(version: 20160407022454) do

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "approved",     default: false
    t.string   "provider"
    t.string   "uid"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "status",      default: "open"
    t.text     "tags"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "agency_id"
    t.boolean  "approved",    default: false
  end

  add_index "projects", ["agency_id"], name: "index_projects_on_agency_id"

  create_table "projects_tamu_users", id: false, force: :cascade do |t|
    t.integer "project_id",   null: false
    t.integer "tamu_user_id", null: false
  end

  create_table "tamu_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "role"
    t.boolean  "admin",      default: false
  end

end
