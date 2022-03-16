class Etl::Teams::AllTeamsJob < Etl::BaseJob

  def initialize(season)
    super
    @season = season
    @transformed_data = []
  end

  private

  def extract
    @extracted_data = MlbClient.fetch_teams(@season)
  end

  def transform
    @extracted_data.map do |extracted_team|
      @transformed_data << {
        venue: extracted_team['venue_short'],
      	name: extracted_team['name'],
      	franchise_code: extracted_team['franchise_code'],
      	sport_code: extracted_team['sport_code'],
      	city: extracted_team['city'],
      	full_display_name: extracted_team['name_display_full'],
      	time_zone: extracted_team['time_zone_text'],
      	alternate_time_zone: extracted_team['time_zone_alt'],
      	league_long: extracted_team['league_full'],
      	league_short: extracted_team['league_abbrev'],
      	abbreviated_name: extracted_team['name_abbrev'],
      	team_code: extracted_team['team_id'],
      	base_url: extracted_team['base_url'],
      	address_line1: extracted_team['address_line1'],
      	address_line2: extracted_team['address_line2'],
      	address_line3: extracted_team['address_line3'],
      	division_short: extracted_team['division_abbrev'],
        division_long: extracted_team['division_full'],
      	state: extracted_team['state'],
      	website_url: extracted_team['website_url'],
      	time_zone_utc_offset: extracted_team['time_zone_num']
      }
    end
  end

  def load
    @transformed_data.each do |transformed_team|
      Team.find_or_create_by!(team_code: transformed_team[:team_code], name: transformed_team[:name]) do |team_to_load|
        team_to_load.venue                = transformed_team[:venue]
      	team_to_load.name                 = transformed_team[:name]
      	team_to_load.franchise_code       = transformed_team[:franchise_code]
      	team_to_load.sport_code           = transformed_team[:sport_code]
      	team_to_load.city                 = transformed_team[:city]
      	team_to_load.full_display_name    = transformed_team[:full_display_name]
      	team_to_load.time_zone            = transformed_team[:time_zone]
      	team_to_load.alternate_time_zone  = transformed_team[:alternate_time_zone]
      	team_to_load.league_long          = transformed_team[:league_long]
      	team_to_load.league_short         = transformed_team[:league_short]
      	team_to_load.abbreviated_name     = transformed_team[:abbreviated_name]
      	team_to_load.team_code            = transformed_team[:team_code]
      	team_to_load.base_url             = transformed_team[:base_url]
      	team_to_load.address_line1        = transformed_team[:address_line1]
      	team_to_load.address_line2        = transformed_team[:address_line2]
      	team_to_load.address_line3        = transformed_team[:address_line3]
      	team_to_load.division_short       = transformed_team[:division_short]
        team_to_load.division_long        = transformed_team[:division_long]
      	team_to_load.state                = transformed_team[:state]
      	team_to_load.website_url          = transformed_team[:website_url]
      	team_to_load.time_zone_utc_offset = transformed_team[:time_zone_utc_offset]
      end
    end
  end
end
