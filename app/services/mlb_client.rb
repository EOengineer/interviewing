require 'rest-client'

module MlbClient
  def self.fetch_teams(season)
    url  = "#{ENV['MLB_API_BASE_URL']}/named.team_all_season.bam?sport_code='mlb'&all_star_sw='N'&sort_order='name_asc'&season='#{season}'"
    resp = getMlbData(url)
    JSON.parse(resp.body)['team_all_season']['queryResults']['row']
  end

  def self.fetch_players(team_code, season)
    url = "#{ENV['MLB_API_BASE_URL']}/named.roster_team_alltime.bam?team_id='#{team_code}'&start_season='#{season}'&end_season='#{season}'"
    resp = getMlbData(url)
    JSON.parse(resp.body)['roster_team_alltime']['queryResults']['row']
  end

  def self.getMlbData(url)
    begin
      resp = RestClient.get(url)
    rescue RestClient::ExceptionWithResponse => e
      puts "something went wrong #{e.inspect}"
      # ship exception to monitoring service: TBD.
    else
      resp
    end
  end
end
