require 'rest-client'

module MlbClient
  def self.fetch_teams(season)
    url = "#{ENV['MLB_API_BASE_URL']}/named.team_all_season.bam?sport_code='mlb'&all_star_sw='N'&sort_order='name_asc'&season='#{season}'"
    begin
      resp = RestClient.get(url)
    rescue RestClient::ExceptionWithResponse => e
      # ship exception to monitoring service: TBD.
    else
      JSON.parse(resp.body)['team_all_season']['queryResults']['row']
    end
  end
end
