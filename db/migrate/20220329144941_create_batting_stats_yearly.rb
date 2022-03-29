class CreateBattingStatsYearly < ActiveRecord::Migration[6.1]
  def change
    create_table :batting_stats_yearlies do |t|
      t.integer :hr, null: false
      t.integer :year, null: false
      t.integer :ab, default: 0
      t.integer :hldr, default: 0
      t.string :league, null: false
      t.integer :ao, default: 0
      t.string :slg, null: false
      t.string :ops, null: false
      t.integer :hbp, default: 0
      t.integer :rbi, default: 0
      t.string :go_ao, null: false
      t.integer :hfly, default: 0
      t.integer :lob, default: 0
      t.integer :xbh, default: 0
      t.datetime :end_date
      t.integer :bb, default: 0
      t.integer :np, default: 0
      t.integer :hgnd, default: 0
      t.integer :roe, default: 0
      t.integer :sb, default: 0
      t.references :player # references our players.id
      t.string :player_code, null: false # references API source player_id
      t.string :avg, null: false
      t.integer :sf, default: 0
      t.integer :sac, default: 0
      t.integer :wo, default: 0
      t.integer :hpop, default: 0
      t.integer :so, default: 0
      t.integer :gidp_opp, default: 0
      t.integer :gidp, default: 0
      t.string :ppa, null: false
      t.integer :d, default: 0
      t.integer :tpa, default: 0
      t.integer :g, default: 0
      t.integer :h, default: 0
      t.integer :ibb, default: 0
      t.integer :go, default: 0
      t.string :team_seq
      t.integer :tb, default: 0
      t.integer :cs, default: 0
      t.integer :r, default: 0
      t.integer :t, default: 0
      t.string :babip, null: false
      t.string :obp, null: false

      t.timestamps
    end
    add_index :batting_stats_yearlies, :year
    add_index :batting_stats_yearlies, :player_code
    add_index :batting_stats_yearlies, [:player_code, :year], unique: true
    add_index :batting_stats_yearlies, [:player_id, :year], unique: true
  end
end
