class Etl::Rosters::YearlyRostersJob < Etl::BaseJob
  # creates a roster record for each team for a provided season (year).

  private

  def set_keys(*args)
    super
    @season = @args[0] # receives a year string representing a single season
    @transformed_data = []
  end

  # not used
  def extract
  end

  # not used
  def transform
  end

  # the extract and transform steps are bypassed in this job because we referencing
  # our own data to set up the roster entry to normalize the database.
  def load
    puts "Saving Roster for #{@season}...."
    Team.all.each do |team|
      puts "Saving #{@season} roster for the #{team.name}...."
      Roster.where(team_id: team.id, year: @season).first_or_initialize do |roster_to_load|
        roster_to_load.team_id = team.id
        roster_to_load.team_code = team.team_code
        roster_to_load.year = @season
        create_or_update_record(roster_to_load)
      end
    end

  end

  # attributes used in the lookup of existing records
  def finder_attributes
    %i[team_code team_id year]
  end

  # attributes that should be passed into the .update method for existing records
  def writable_attributes
    %w[team_code team_id year]
  end


end
