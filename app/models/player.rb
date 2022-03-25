class Player < ApplicationRecord
  belongs_to :roster
  belongs_to :team

  validates :player_code,
            :name,
            :name_sort,
            :year,
            presence: true
end
