# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110213085640) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batting_score_cards", :force => true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.string   "wicket_desc"
    t.integer  "score"
    t.integer  "fours"
    t.integer  "sixes"
    t.float    "strike_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bowling_score_cards", :force => true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.float    "overs"
    t.integer  "maidens"
    t.integer  "runs"
    t.integer  "wickets"
    t.integer  "extras"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "economy_rate"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_totals", :force => true do |t|
    t.integer  "match_id"
    t.integer  "country_id"
    t.integer  "score"
    t.integer  "balls"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.string   "match_type",     :null => false
    t.integer  "stadium_id"
    t.date     "date",           :null => false
    t.boolean  "day_night",      :null => false
    t.integer  "country_one_id"
    t.integer  "country_two_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "match_status"
  end

  create_table "player_match_points", :force => true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "display_name"
    t.string   "short_name"
    t.string   "role"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stadia", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_game_datas", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "player_order"
    t.integer  "points"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
