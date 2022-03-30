class BattingStatsYearly < ApplicationRecord
  belongs_to :player

  validates :hr,
            :year,
            :league,
            :slg,
            :player_code,
            :ops,
            :go_ao,
            :avg,
            :ppa,
            :babip,
            :obp, presence: true

  validates :year, uniqueness: { scope: :player_id }
  validates :year, uniqueness: { scope: :player_code }
end
