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

ActiveRecord::Schema.define(version: 20150827132516) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
    t.integer  "roles",                  limit: 4
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "admin_email", limit: 255
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "emails", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.integer  "ttype",       limit: 4
    t.string   "subject",     limit: 255
    t.text     "body_html",   limit: 65535
    t.text     "body_text",   limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "emails", ["category_id"], name: "index_emails_on_category_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ttype",       limit: 4
    t.text     "description", limit: 65535
    t.integer  "limit",       limit: 4
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "price",       limit: 4
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree

  create_table "inscriptions", force: :cascade do |t|
    t.integer  "event_id",             limit: 4
    t.string   "first_name",           limit: 255
    t.string   "last_name",            limit: 255
    t.integer  "phone",                limit: 8
    t.string   "email",                limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "status",               limit: 4
    t.text     "motive",               limit: 65535
    t.string   "document_id",          limit: 255
    t.integer  "sex",                  limit: 4
    t.date     "born_at"
    t.text     "address",              limit: 65535
    t.string   "parroquia",            limit: 255
    t.string   "canton",               limit: 255
    t.string   "provincia",            limit: 255
    t.string   "ed_level",             limit: 255
    t.string   "ed_unity",             limit: 255
    t.text     "observations",         limit: 65535
    t.string   "rep_document_id",      limit: 255
    t.text     "rep_full_name",        limit: 65535
    t.integer  "rep_sex",              limit: 4
    t.string   "rep_title",            limit: 255
    t.integer  "rep_phone_home",       limit: 8
    t.integer  "rep_phone_celular",    limit: 8
    t.string   "rep_parroquia",        limit: 255
    t.string   "rep_canton",           limit: 255
    t.string   "rep_provincia",        limit: 255
    t.text     "rep_address",          limit: 65535
    t.string   "rep_work_name",        limit: 255
    t.text     "rep_work_address",     limit: 65535
    t.integer  "rep_work_phone",       limit: 8
    t.text     "admin_observation",    limit: 65535
    t.datetime "appointed_at"
    t.text     "plant_location",       limit: 65535
    t.text     "plant_representation", limit: 65535
  end

  add_index "inscriptions", ["event_id"], name: "index_inscriptions_on_event_id", using: :btree

  create_table "inscriptions_plants", force: :cascade do |t|
    t.integer  "inscription_id", limit: 4
    t.integer  "plant_id",       limit: 4
    t.integer  "quantity",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inscriptions_plants", ["inscription_id"], name: "index_inscriptions_plants_on_inscription_id", using: :btree
  add_index "inscriptions_plants", ["plant_id"], name: "index_inscriptions_plants_on_plant_id", using: :btree

  create_table "plants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "dow",         limit: 4
    t.integer  "starts_hour", limit: 4
    t.integer  "ends_hour",   limit: 4
    t.integer  "time",        limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_foreign_key "emails", "categories"
  add_foreign_key "events", "categories"
end
