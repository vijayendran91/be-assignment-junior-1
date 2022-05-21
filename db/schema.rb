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

ActiveRecord::Schema.define(version: 2022_05_21_165333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.float "amount"
    t.integer "no_parts"
    t.string "desc", limit: 200
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "paid_by_id"
    t.index ["paid_by_id"], name: "index_bills_on_paid_by_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.float "amount"
    t.boolean "settled", default: false
    t.string "notes", limit: 150
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "borrowed_from_id", null: false
    t.bigint "borrower_id", null: false
    t.bigint "bill_id"
    t.string "borrowed_from_name"
    t.string "borrower_name"
    t.index ["bill_id"], name: "index_expenses_on_bill_id"
    t.index ["borrowed_from_id"], name: "index_expenses_on_borrowed_from_id"
    t.index ["borrower_id"], name: "index_expenses_on_borrower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.float "total_owe"
    t.float "total_owed"
  end

  add_foreign_key "bills", "users", column: "paid_by_id"
  add_foreign_key "expenses", "bills"
  add_foreign_key "expenses", "users", column: "borrowed_from_id"
  add_foreign_key "expenses", "users", column: "borrower_id"
end
