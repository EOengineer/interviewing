class Player < ApplicationRecord
  belongs_to :roster
  belongs_to :team

  has_many :batting_stat_yearlies, dependent: :destroy

  validates :player_code,
            :name,
            :name_sort,
            :year,
            presence: true
end
