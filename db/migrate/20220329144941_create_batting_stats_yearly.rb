class CreateBattingStatsYearly < ActiveRecord::Migration[6.1]
  def change
    create_table :batting_stats_yearlies do |t|
      t.integer :hr
      t.integer :year, null: false
      t.integer :ab
      t.integer :hldr
      t.string :league
      t.integer :ao
      t.string :slg
      t.string :ops
      t.integer :hbp
      t.integer :rbi
      t.string :go_ao
      t.integer :hfly
      t.integer :lob
      t.integer :xbh
      t.datetime :end_date
      t.integer :bb
      t.integer :np
      t.integer :hgnd
      t.integer :roe
      t.integer :sb
      t.references :player # references our players.id
      t.string :player_code, null: false # references API source player_id
      t.string :avg
      t.integer :sf
      t.integer :sac
      t.integer :wo
      t.integer :hpop
      t.integer :so
      t.integer :gidp_opp
      t.integer :gidp
      t.string :ppa
      t.integer :d
      t.integer :tpa
      t.integer :g
      t.integer :h
      t.integer :ibb
      t.integer :go
      t.string :team_seq
      t.integer :tb
      t.integer :cs
      t.integer :r
      t.integer :t
      t.string :babip
      t.string :obp

      t.timestamps
    end
    add_index :batting_stats_yearlies, :year
    add_index :batting_stats_yearlies, :player_code
    add_index :batting_stats_yearlies, [:player_code, :year], unique: true
    add_index :batting_stats_yearlies, [:player_id, :year], unique: true
  end
end
