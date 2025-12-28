# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_12_28_180000) do
  create_table "invites", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "email", null: false
    t.string "role", null: false
    t.string "token", default: "gen_random_uuid()", null: false
    t.integer "invited_by_id", null: false
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invited_by_id"], name: "index_invites_on_invited_by_id"
    t.index ["project_id", "email"], name: "index_invites_unique_pending", unique: true, where: "accepted_at IS NULL"
    t.index ["project_id"], name: "index_invites_on_project_id"
    t.index ["token"], name: "index_invites_on_token", unique: true
  end

  create_table "project_memberships", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_memberships_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_project_memberships_on_project_id"
    t.index ["user_id"], name: "index_project_memberships_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower(email)", name: "index_users_on_lower_email", unique: true
  end

  add_foreign_key "invites", "projects"
  add_foreign_key "invites", "users", column: "invited_by_id"
  add_foreign_key "project_memberships", "projects"
  add_foreign_key "project_memberships", "users"
end
