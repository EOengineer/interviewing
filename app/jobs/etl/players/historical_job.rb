class Etl::Players::HistoricalJob < ApplicationJob
  # Kicks off roster creation for 5 most recent seasons
  def perform()
    Roster.all.each do |roster|
      Etl::Players::YearlyJob.perform_later(roster.year, roster.team_id, roster.id)
    end
  end

  def range_start
    5.years.ago.year
  end

  def range_end
    Date.today.year
  end
end
