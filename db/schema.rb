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

ActiveRecord::Schema.define(version: 20160701102101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "roles"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "emails", force: :cascade do |t|
    t.integer  "ttype"
    t.string   "subject"
    t.text     "body_html"
    t.text     "body_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  add_index "emails", ["event_id"], name: "index_emails_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ttype"
    t.text     "description"
    t.integer  "limit"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "price"
    t.string   "slug"
    t.string   "admin_email"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "inscriptions", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "phone",                limit: 8
    t.string   "email"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "status"
    t.text     "motive"
    t.string   "document_id"
    t.integer  "sex"
    t.date     "born_at"
    t.text     "address"
    t.string   "parroquia"
    t.string   "canton"
    t.string   "provincia"
    t.string   "ed_level"
    t.text     "observations"
    t.string   "rep_document_id"
    t.text     "rep_full_name"
    t.integer  "rep_sex"
    t.string   "rep_title"
    t.integer  "rep_phone_home",       limit: 8
    t.integer  "rep_phone_celular",    limit: 8
    t.string   "rep_parroquia"
    t.string   "rep_canton"
    t.string   "rep_provincia"
    t.text     "rep_address"
    t.string   "rep_work_name"
    t.text     "rep_work_address"
    t.integer  "rep_work_phone",       limit: 8
    t.text     "admin_observation"
    t.datetime "appointed_at"
    t.text     "plant_location"
    t.text     "plant_representation"
    t.text     "office"
    t.integer  "institute_id"
    t.integer  "ed_title"
    t.string   "google_calendar_id"
    t.string   "google_calendar_link"
  end

  add_index "inscriptions", ["event_id"], name: "index_inscriptions_on_event_id", using: :btree
  add_index "inscriptions", ["institute_id"], name: "index_inscriptions_on_institute_id", using: :btree

  create_table "inscriptions_plants", force: :cascade do |t|
    t.integer  "inscription_id"
    t.integer  "plant_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inscriptions_plants", ["inscription_id"], name: "index_inscriptions_plants_on_inscription_id", using: :btree
  add_index "inscriptions_plants", ["plant_id"], name: "index_inscriptions_plants_on_plant_id", using: :btree

  create_table "institutes", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "principal_name"
    t.string   "phone"
    t.string   "address"
    t.string   "parroquia"
    t.string   "canton"
    t.string   "provincia"
    t.date     "foundated_at"
    t.integer  "ttype"
    t.integer  "students_number"
  end

  create_table "instructors", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "document_id"
    t.text     "full_name"
    t.date     "born_at"
    t.integer  "sex"
    t.string   "title"
    t.string   "phone"
    t.string   "phone_home"
    t.text     "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "instructors", ["event_id"], name: "index_instructors_on_event_id", using: :btree

  create_table "plants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "dow"
    t.integer  "starts_hour"
    t.integer  "ends_hour"
    t.integer  "time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "emails", "events"
  add_foreign_key "inscriptions", "institutes"
  add_foreign_key "instructors", "events"
end
