class CreateRosters < ActiveRecord::Migration[6.1]
  def change
    create_table :rosters do |t|
      t.references :team, null: false, foreign_key: true
      t.string :team_code, null: false
      t.string :year, null: false

      t.timestamps
    end
    add_index :rosters, :year
    add_index :rosters, :team_code
    add_index :rosters, [:team_id, :year], unique: true
  end
end
