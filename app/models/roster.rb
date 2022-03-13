class Roster < ApplicationRecord
  belongs_to :team
  has_many :players, dependent: :destroy

  validates :year, presence: true
end
