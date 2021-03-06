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

ActiveRecord::Schema.define(version: 2022_04_06_181002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batting_stats_yearlies", force: :cascade do |t|
    t.integer "hr"
    t.integer "year", null: false
    t.integer "ab"
    t.integer "hldr"
    t.string "league"
    t.integer "ao"
    t.string "slg"
    t.string "ops"
    t.integer "hbp"
    t.integer "rbi"
    t.string "go_ao"
    t.integer "hfly"
    t.integer "lob"
    t.integer "xbh"
    t.datetime "end_date"
    t.integer "bb"
    t.integer "np"
    t.integer "hgnd"
    t.integer "roe"
    t.integer "sb"
    t.bigint "player_id"
    t.string "player_code", null: false
    t.string "avg"
    t.integer "sf"
    t.integer "sac"
    t.integer "wo"
    t.integer "hpop"
    t.integer "so"
    t.integer "gidp_opp"
    t.integer "gidp"
    t.string "ppa"
    t.integer "d"
    t.integer "tpa"
    t.integer "g"
    t.integer "h"
    t.integer "ibb"
    t.integer "go"
    t.string "team_seq"
    t.integer "tb"
    t.integer "cs"
    t.integer "r"
    t.integer "t"
    t.string "babip"
    t.string "obp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_code", "year"], name: "index_batting_stats_yearlies_on_player_code_and_year", unique: true
    t.index ["player_code"], name: "index_batting_stats_yearlies_on_player_code"
    t.index ["player_id", "year"], name: "index_batting_stats_yearlies_on_player_id_and_year", unique: true
    t.index ["player_id"], name: "index_batting_stats_yearlies_on_player_id"
    t.index ["year"], name: "index_batting_stats_yearlies_on_year"
  end

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
    t.integer "year", null: false
    t.string "name_last_first", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "player_code", "year"], name: "index_players_on_name_and_player_code_and_year"
    t.index ["name"], name: "index_players_on_name"
    t.index ["name_sort"], name: "index_players_on_name_sort"
    t.index ["player_code"], name: "index_players_on_player_code"
    t.index ["roster_id"], name: "index_players_on_roster_id"
    t.index ["team_id"], name: "index_players_on_team_id"
    t.index ["year"], name: "index_players_on_year"
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "team_code", null: false
    t.integer "year", null: false
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "favorite_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["favorite_team_id"], name: "index_users_on_favorite_team_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "players", "rosters"
  add_foreign_key "players", "teams"
  add_foreign_key "rosters", "teams"
  add_foreign_key "users", "teams", column: "favorite_team_id"
end
