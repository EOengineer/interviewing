class Etl::Teams::AllTeamsJob < Etl::BaseJob

  private

  def set_keys(*args)
    super
    @transformed_data = []
    @season = @args[0]
  end

  def extract
    @extracted_data = MlbClient.fetch_teams(@season)
    puts "extracting teams for #{@season}...."
  end

  def transform
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
    puts "transforming teams for #{@season}...."
  end

  def load
    @transformed_data.each do |transformed_team|
      lookup_attributes = {
        team_code: transformed_team[:team_code],
        name: transformed_team[:name],
        year: transformed_team[:year]
      }

      Team.where(lookup_attributes).first_or_initialize do |team_to_load|
        updated_attributes = {}
        # populate the model
        writable_attributes.each do |attribute|
          team_to_load[attribute] = transformed_team[attribute.to_sym]
          updated_attributes[attribute.to_sym] = transformed_team[attribute.to_sym]
        end

        # save the model
        if team_to_load.new_record?
          team_to_load.save!
        else
          team_to_load.update!(updated_attributes)
        end
      end
    end
    puts "Saving teams for #{@season}...."
  end

  def writable_attributes
    %w[venue franchise_code sport_code
       city full_display_name time_zone alternate_time_zone
       league_long league_short abbreviated_name base_url
       address_line1 address_line2 address_line3 division_short division_long
       state website_url time_zone_utc_offset]
  end
end
