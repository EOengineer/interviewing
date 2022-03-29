class Etl::BattingStats::YearlyJob < Etl::BaseJob
  # Operates on all the teams for a provided season.

  private

  def set_keys(*args)
    super
    @player_id = @args[0] # receives a players.id that is used to look up the player
    @player    = Player.find(@player_id)
    @transformed_data = {}
  end

  def extract
    puts "extracting #{@player.year} hitting stats for #{@player.name_last_first}...."

    @extracted_data = MlbClient.fetch_hitting_stats(@player.player_code, @player.year)
  end

  def transform
    puts "transforming #{@player.year} hitting stats for #{@player.name_last_first}...."

    writable_attributes.each do |metric|
      @transformed_data[metric.to_sym] = @extracted_data[metric]
    end
    @transformed_data[:year] = @extracted_data['season'].to_i
    @transformed_data[:player_code] = @extracted_data['player_id']
    @transformed_data[:player_id] = @player.id
  end

  def load
    puts "Saving #{@player.year} hitting stats for #{@player.name_last_first}...."

    BattingStatsYearly
      .where(populate_attributes(finder_attributes, @transformed_data))
      .first_or_initialize do |batting_stat|
        # populate the model
        writable_attributes.each do |attribute|
          batting_stat[attribute] = @transformed_data[attribute.to_sym]
        end
        batting_stat.player_code = @transformed_data[:player_code]
        batting_stat.player_id = @transformed_data[:player_id]
        # save the model
        create_or_update_record(batting_stat)
      end
  end

  # attributes used in the lookup of existing records
  def finder_attributes
    %i[player_code year]
  end

  # attributes that should be passed into the .update method for existing records
  def writable_attributes
    %w[hr ab hldr league ao slg ops hbp rbi go_ao hfly
      lob xbh end_date bb np hgnd roe sb avg sf sac wo
      hpop so gidp_opp gidp ppa d tpa g h ibb go team_seq tb cs r t babip obp]
  end
end
