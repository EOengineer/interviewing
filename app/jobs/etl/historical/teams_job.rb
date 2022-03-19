class Etl::Historical::TeamsJob < ApplicationJob
  def perform()
    current_year   = Date.today.year
    five_years_ago = 5.years.ago.year
    (five_years_ago...current_year).to_a.each do |year|
      Etl::Teams::AllTeamsJob.perform_later(year)
    end
  end
end
