class Etl::BattingStats::HistoricalJob < ApplicationJob
  # Kicks off yearly batting stats creation for each player record in system
  def perform()
    Player.all.order(default_sort).each do |player|
      Etl::BattingStats::YearlyJob.perform_later(player.id)
    end
  end

  def range_start
    5.years.ago.year
  end

  def range_end
    Date.today.year
  end

  def default_sort
    'year DESC, name'
  end
end
