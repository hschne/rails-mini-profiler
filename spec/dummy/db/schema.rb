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

ActiveRecord::Schema.define(version: 2021_06_21_185018) do
  create_table "movies", force: :cascade do |t|
    t.string "imdb_id"
    t.decimal "popularity", precision: 5, scale: 2
    t.decimal "budget"
    t.decimal "revenue"
    t.string "title"
    t.decimal "runtime", precision: 3
    t.date "release_date"
  end

  create_table "rmp_flamegraphs", force: :cascade do |t|
    t.integer "rmp_profiled_request_id", null: false
    t.json "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rmp_profiled_request_id"], name: "index_rmp_flamegraphs_on_rmp_profiled_request_id"
  end

  create_table "rmp_profiled_requests", force: :cascade do |t|
    t.string "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.integer "duration"
    t.integer "allocations"
    t.integer "response_status"
    t.json "response_body"
    t.json "response_headers"
    t.string "request_path"
    t.json "request_headers"
    t.json "request_body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rmp_traces", force: :cascade do |t|
    t.integer "rmp_profiled_request_id", null: false
    t.string "name"
    t.datetime "start"
    t.datetime "finish"
    t.integer "duration"
    t.integer "allocations"
    t.json "payload"
    t.json "backtrace"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rmp_profiled_request_id"], name: "index_rmp_traces_on_rmp_profiled_request_id"
  end

  add_foreign_key "rmp_flamegraphs", "rmp_profiled_requests"
  add_foreign_key "rmp_traces", "rmp_profiled_requests"
end
