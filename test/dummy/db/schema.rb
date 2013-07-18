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

ActiveRecord::Schema.define(version: 20130717064644) do

  create_table "learnery_events", force: true do |t|
    t.string   "name"
    t.datetime "starts"
    t.datetime "ends"
    t.string   "venue"
    t.string   "description",   default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_attendees", default: 0,  null: false
    t.integer  "topic_id"
    t.string   "type"
  end

  create_table "learnery_rsvps", force: true do |t|
    t.string   "answer"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",         default: "Learnery::OpenRsvp"
    t.datetime "asked_at"
    t.datetime "confirmed_at"
  end

  add_index "learnery_rsvps", ["user_id", "event_id"], name: "index_rsvps_on_user_id_and_event_id", unique: true

  create_table "learnery_topics", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "event_id"
    t.integer  "suggested_by_id"
    t.integer  "presented_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learnery_users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  default: false
  end

  add_index "learnery_users", ["email"], name: "index_users_on_email", unique: true
  add_index "learnery_users", ["firstname"], name: "index_users_on_firstname"
  add_index "learnery_users", ["lastname"], name: "index_users_on_lastname"
  add_index "learnery_users", ["nickname"], name: "index_users_on_nickname"
  add_index "learnery_users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
