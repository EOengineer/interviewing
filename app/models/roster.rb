class Roster < ApplicationRecord
  belongs_to :team
  has_many :players, dependent: :destroy

  validates :year, :team_code, presence: true
end
