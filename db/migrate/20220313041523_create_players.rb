class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :roster, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.date :birth_date
      t.string :feet
      t.integer :inches
      t.integer :weight
      t.string :position
      t.string :abbreviated_position
      t.string :player_code, null: false # player_id in mlb api
      t.string :throw_orientation
      t.string :bat_orientation
      t.integer :number
      t.string :name, null: false
      t.string :name_sort, null: false
      t.string :status
      t.string :roster_year, null: false

      t.timestamps
    end
    add_index :players, :name
    add_index :players, :name_sort
    add_index :players, :player_code
    add_index :players, :roster_year
  end
end
