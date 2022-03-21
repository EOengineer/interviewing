class Team < ApplicationRecord
  has_many :rosters, dependent: :destroy
  has_many :players, dependent: :destroy

  validates :name,
            :abbreviated_name,
            :team_code,
            presence: true

  validates :name, uniqueness: true
end
