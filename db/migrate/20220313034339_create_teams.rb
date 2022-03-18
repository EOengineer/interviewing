class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.integer :year
    	t.string :venue
    	t.string :name, null: false
    	t.string :franchise_code
    	t.string :sport_code
    	t.string :city
    	t.string :full_display_name
    	t.string :time_zone
    	t.string :alternate_time_zone
    	t.string :league_long
    	t.string :league_short
    	t.string :abbreviated_name, null: false
    	t.string :team_code, null: false # team_id in mlb api response
    	t.string :base_url
    	t.string :address_line1
    	t.string :address_line2
    	t.string :address_line3
    	t.string :division_short
      t.string :division_long
    	t.string :state
    	t.string :website_url
    	t.string :time_zone_utc_offset

      t.timestamps
    end
    add_index :teams, :name
    add_index :teams, :team_code
    add_index :teams, :year
    add_index :teams, [:year, :name], unique: true
  end
end
