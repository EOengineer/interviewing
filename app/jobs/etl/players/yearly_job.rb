class Etl::Players::YearlyJob < Etl::BaseJob
  # Operates on all the teams for a provided season.

  private

  def set_keys(*args)
    super
    @season           = @args[0] # receives a year string representing a single season
    @team_id          = @args[1] # receives a team_id so we can get the associated team code for the api request
    @roster_id        = @args[2] # receives a roster_id that can be used to form roster association
    @transformed_data = []
    @team             = Team.find(@team_id)
    @roster           = Roster.find_by(team_id: @team_id, year: @season)
  end

  def extract
    puts "extracting players for #{@season} #{@team.name}...."
    @extracted_data = MlbClient.fetch_players(@team.team_code, @season)

  end

  def transform
    puts "transforming players for #{@season} #{@team.name}...."
    # binding.pry
    @transformed_data = @extracted_data.map do |extracted_player|
      {
        roster_id: @roster_id,
        team_id: @team_id,
        birth_date: extracted_player['birth_date'],
        feet: extracted_player['height_feet'],
        inches: extracted_player['height_inches'],
        weight: extracted_player['weight'],
        position: extracted_player['position_desig'],
        abbreviated_position: extracted_player['primary_position'],
        player_code: extracted_player['player_id'],
        throw_orientation: extracted_player['throws'],
        bat_orientation: extracted_player['bats'],
        number: extracted_player['jersey_number'],
        name: extracted_player['name_first_last'],
        name_sort: extracted_player['name_sort'],
        status: extracted_player['status_short'],
        name_last_first: extracted_player['name_last_first'],
        year: @season
      }
    end
  end

  def load
    puts "Saving teams for #{@season} #{@team.name}...."
    @transformed_data.each do |transformed_team|
      finder_hash = populate_attributes(finder_attributes, transformed_team)

      player = Player.where(finder_hash).first_or_initialize do |player_to_load|
        # populate the model
        writable_attributes.each do |attribute|
          player_to_load[attribute] = transformed_team[attribute.to_sym]
        end
        # save the model
        create_or_update_record(player_to_load)
      end
    end
  end

  # attributes used in the lookup of existing records
  def finder_attributes
    %i[team_id year player_code]
  end

  # attributes that should be passed into the .update method for existing records
  def writable_attributes
    %w[roster_id team_id birth_date feet inches weight position
       abbreviated_position player_code throw_orientation bat_orientation
       number name name_sort status name_last_first year]
  end


end
