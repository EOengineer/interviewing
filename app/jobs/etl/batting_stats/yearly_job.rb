class Etl::BattingStats::YearlyJob < Etl::BaseJob
  # Operates on all the teams for a provided season.

  private

  def set_keys(*args)
    super
    @player_id = @args[0] # receives a players.id that is used to look up the player record
    @player    = Player.find(@player_id)
    @transformed_data = {}
  end

  def extract
    puts "extracting #{@player.year} hitting stats for #{@player.name_last_first}...."

    @extracted_data = MlbClient.fetch_hitting_stats(@player.player_code, @player.year)
  end

  def transform
    puts "transforming #{@player.year} hitting stats for #{@player.name_last_first}...."

    # In some cases, the API may return an array if a player played for multiple teams that year.
    # We select the stats matching the current roster team.
    if @extracted_data.is_a?(Array)
      @extracted_data = @extracted_data.find { |stat| stat['team_id'] = @player.roster.team.team_code }
    end

    if @extracted_data.present?
      @transformed_data[:year] = @extracted_data['season']
      @transformed_data[:player_code] = @extracted_data['player_id']
      @transformed_data[:player_id] = @player.id
      @transformed_data[:hr] = @extracted_data['hr']
      @transformed_data[:ab] = @extracted_data['ab']
      @transformed_data[:hldr] = @extracted_data['hldr']
      @transformed_data[:league] = @extracted_data['league']
      @transformed_data[:ao] = @extracted_data['ao']
      @transformed_data[:slg] = @extracted_data['slg']
      @transformed_data[:ops] = @extracted_data['ops']
      @transformed_data[:hbp] = @extracted_data['hbp']
      @transformed_data[:rbi] = @extracted_data['rbi']
      @transformed_data[:go_ao] = @extracted_data['go_ao']
      @transformed_data[:hfly] = @extracted_data['hfly']
      @transformed_data[:lob] = @extracted_data['lob']
      @transformed_data[:xbh] = @extracted_data['xbh']
      @transformed_data[:end_date] = @extracted_data['end_date']
      @transformed_data[:bb] = @extracted_data['bb']
      @transformed_data[:np] = @extracted_data['np']
      @transformed_data[:hgnd] = @extracted_data['hgnd']
      @transformed_data[:roe] = @extracted_data['roe']
      @transformed_data[:sb] = @extracted_data['sb']
      @transformed_data[:avg] = @extracted_data['avg']
      @transformed_data[:sf] = @extracted_data['sf']
      @transformed_data[:sac] = @extracted_data['sac']
      @transformed_data[:wo] = @extracted_data['wo']
      @transformed_data[:hpop] = @extracted_data['hpop']
      @transformed_data[:so] = @extracted_data['so']
      @transformed_data[:gidp_opp] = @extracted_data['gidp_opp']
      @transformed_data[:ppa] = @extracted_data['ppa']
      @transformed_data[:d] = @extracted_data['d']
      @transformed_data[:tpa] = @extracted_data['tpa']
      @transformed_data[:g] = @extracted_data['g']
      @transformed_data[:h] = @extracted_data['h']
      @transformed_data[:ibb] = @extracted_data['ibb']
      @transformed_data[:go] = @extracted_data['go']
      @transformed_data[:so] = @extracted_data['so']
      @transformed_data[:team_seq] = @extracted_data['team_seq']
      @transformed_data[:tb] = @extracted_data['tb']
      @transformed_data[:cs] = @extracted_data['cs']
      @transformed_data[:r] = @extracted_data['r']
      @transformed_data[:t] = @extracted_data['t']
      @transformed_data[:babip] = @extracted_data['babip']
      @transformed_data[:obp] = @extracted_data['obp']
    end
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
