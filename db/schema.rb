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

ActiveRecord::Schema.define(version: 20170827223037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_choices_on_option_id", using: :btree
    t.index ["user_id"], name: "index_choices_on_user_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "menu_bloc_memberships", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "menu_bloc_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["menu_bloc_id"], name: "index_menu_bloc_memberships_on_menu_bloc_id", using: :btree
    t.index ["menu_id"], name: "index_menu_bloc_memberships_on_menu_id", using: :btree
  end

  create_table "menu_blocs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_options_on_meal_id", using: :btree
    t.index ["menu_id"], name: "index_options_on_menu_id", using: :btree
  end

  create_table "slack_teams", force: :cascade do |t|
    t.string   "access_token"
    t.string   "team_name"
    t.string   "team_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["team_id"], name: "index_slack_teams_on_team_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "slack_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "choices", "options"
  add_foreign_key "choices", "users"
  add_foreign_key "menu_bloc_memberships", "menu_blocs"
  add_foreign_key "menu_bloc_memberships", "menus"
  add_foreign_key "options", "meals"
  add_foreign_key "options", "menus"
end
