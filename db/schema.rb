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

ActiveRecord::Schema.define(version: 2022_03_13_041523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.bigint "roster_id", null: false
    t.bigint "team_id", null: false
    t.date "birth_date"
    t.string "feet"
    t.integer "inches"
    t.integer "weight"
    t.string "position"
    t.string "abbreviated_position"
    t.string "player_code", null: false
    t.string "throw_orientation"
    t.string "bat_orientation"
    t.integer "number"
    t.string "name", null: false
    t.string "name_sort", null: false
    t.string "status"
    t.string "roster_year", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_players_on_name"
    t.index ["name_sort"], name: "index_players_on_name_sort"
    t.index ["player_code"], name: "index_players_on_player_code"
    t.index ["roster_id"], name: "index_players_on_roster_id"
    t.index ["roster_year"], name: "index_players_on_roster_year"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "team_code", null: false
    t.string "year", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_code"], name: "index_rosters_on_team_code"
    t.index ["team_id", "year"], name: "index_rosters_on_team_id_and_year", unique: true
    t.index ["team_id"], name: "index_rosters_on_team_id"
    t.index ["year"], name: "index_rosters_on_year"
  end

  create_table "teams", force: :cascade do |t|
    t.string "venue"
    t.string "name", null: false
    t.string "franchise_code"
    t.string "sport_code"
    t.string "city"
    t.string "full_display_name"
    t.string "time_zone"
    t.string "alternate_time_zone"
    t.string "league_long"
    t.string "league_short"
    t.string "abbreviated_name", null: false
    t.string "team_code", null: false
    t.string "base_url"
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_line3"
    t.string "division_short"
    t.string "division_long"
    t.string "state"
    t.string "website_url"
    t.string "time_zone_utc_offset"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_display_name"], name: "index_teams_on_full_display_name"
    t.index ["name"], name: "index_teams_on_name"
    t.index ["team_code"], name: "index_teams_on_team_code"
  end

  add_foreign_key "players", "rosters"
  add_foreign_key "players", "teams"
  add_foreign_key "rosters", "teams"
end
