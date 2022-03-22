class Etl::Rosters::HistoricalRostersJob < ApplicationJob
  # Kicks off teams collection for 5 most recent seasons
  def perform()
    (range_start...range_end).to_a.each do |year|
      Etl::Rosters::YearlyRostersJob.perform_later(year)
    end
  end

  def range_start
    5.years.ago.year
  end

  def range_end
    Date.today.year
  end
end
