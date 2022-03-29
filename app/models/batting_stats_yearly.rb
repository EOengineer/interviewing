class BattingStatsYearly < ApplicationRecord
  belongs_to :player

  validates :hr,
            :team_code,
            :year,
            :league,
            :slg,
            :ops,
            :go_ao,
            :avg,
            :ppa,
            :babip,
            :obp, presence: true
end
