class CreateRosters < ActiveRecord::Migration[6.1]
  def change
    create_table :rosters do |t|
      t.references :team, null: false, foreign_key: true
      t.string :year, null: false

      t.timestamps
    end
    add_index :rosters, :year
  end
end
