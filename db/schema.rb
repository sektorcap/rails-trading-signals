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

ActiveRecord::Schema.define(version: 2018_07_11_011620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.string "message", limit: 1000
    t.string "severity"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolio_items", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stock_id"
    t.float "avg_stock_value"
    t.integer "quantity"
    t.float "sell_stock_value"
    t.string "notes"
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_portfolio_items_on_stock_id"
    t.index ["user_id"], name: "index_portfolio_items_on_user_id"
  end

  create_table "stock_signal_checks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_signals", force: :cascade do |t|
    t.datetime "quotation_date"
    t.float "quotation"
    t.float "min_year"
    t.float "max_year"
    t.float "volatility"
    t.float "dividend_yield"
    t.string "description"
    t.string "details"
    t.integer "suggestion"
    t.integer "level"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_signal_check_id"
    t.index ["stock_id"], name: "index_stock_signals_on_stock_id"
    t.index ["stock_signal_check_id"], name: "index_stock_signals_on_stock_signal_check_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.float "dividend"
    t.string "market"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "quotation_date"
    t.datetime "quotation_check"
    t.float "quotation"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "fullname"
    t.string "provider"
    t.string "extern_uid"
    t.integer "roles_mask"
    t.string "department"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "portfolio_items", "stocks"
  add_foreign_key "portfolio_items", "users"
  add_foreign_key "stock_signals", "stock_signal_checks"
  add_foreign_key "stock_signals", "stocks"
end
