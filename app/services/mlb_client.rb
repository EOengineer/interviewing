require 'rest-client'

module MlbClient
  def self.fetch_teams(season)
    url  = "#{ENV['MLB_API_BASE_URL']}/named.team_all_season.bam?sport_code='mlb'&all_star_sw='N'&sort_order='name_asc'&season='#{season.to_s}'"
    resp = getMlbData(url)
    JSON.parse(resp.body)['team_all_season']['queryResults']['row']
  end

  def self.fetch_players(team_code, season)
    url = "#{ENV['MLB_API_BASE_URL']}/named.roster_team_alltime.bam?team_id='#{team_code}'&start_season='#{season.to_s}'&end_season='#{season.to_s}'"
    resp = getMlbData(url)
    JSON.parse(resp.body)['roster_team_alltime']['queryResults']['row']
  end

  def self.fetch_hitting_stats(player_code, season)
    url = "#{ENV['MLB_API_BASE_URL']}/named.sport_hitting_tm.bam?league_list_id='mlb'&player_id='#{player_code}'&season='#{season.to_s}'&game_type='R'"
    resp = getMlbData(url)
    JSON.parse(resp.body)["sport_hitting_tm"]['queryResults']['row']
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
