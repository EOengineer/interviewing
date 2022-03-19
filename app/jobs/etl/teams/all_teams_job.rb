class Etl::Teams::AllTeamsJob < Etl::BaseJob
  # Operates on all the teams for a provided season.

  private

  def set_keys(*args)
    super
    @season = @args[0] # receives a year string representing a single season
    @transformed_data = []
  end

  def extract
    puts "extracting teams for #{@season}...."
    @extracted_data = MlbClient.fetch_teams(@season)
  end

  def transform
    puts "transforming teams for #{@season}...."

    @extracted_data.map do |extracted_team|
      @transformed_data << {
        year: @season,
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
    puts "Saving teams for #{@season}...."
    @transformed_data.each do |transformed_team|
      finder_hash = populate_attributes(finder_attributes, transformed_team)

      Team.where(finder_hash).first_or_initialize do |team_to_load|
        # populate the model
        writable_attributes.each do |attribute|
          team_to_load[attribute] = transformed_team[attribute.to_sym]
        end
        # save the model
        create_or_update_record(team_to_load)
      end
    end
  end

  # converts [my, hash, keys] => { my: team[my], team: team[hash], key: team[key] }
  def populate_attributes(attribute_array, team)
    attribute_array.to_h { |key| [key, team[key.to_sym]] }
  end

  # attributes used in the lookup of existing records
  def finder_attributes
    %i[team_code name year]
  end

  # attributes that should be passed into the .update method for existing records
  def writable_attributes
    %w[venue franchise_code sport_code
       city full_display_name time_zone alternate_time_zone
       league_long league_short abbreviated_name base_url
       address_line1 address_line2 address_line3 division_short division_long
       state website_url time_zone_utc_offset]
  end

  # determines if new record should be created, or existing one updated.
  def create_or_update_record(team)
    if team.new_record?
      team.save!
    else
      team.update!(populate_attributes(writable_attributes, team))
    end
  end
end
