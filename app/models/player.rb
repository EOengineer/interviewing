class Player < ApplicationRecord
  belongs_to :roster
  belongs_to :team

  validates :player_code,
            :name,
            :name_sort,
            :roster_year,
            presence: true
end
