# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# def local(time)
#   TZInfo::Timezone.get('America/New_York').local_to_utc(Time.parse(time))
# end

set :output, "log/cron_log.log"
env :PATH, ENV['PATH']
set :environment, :development

every 1.day, at: '4:30PM' do
  runner "Etl::Teams::HistoricalJob.perform_later"
end

every 1.day, at: '4:35PM' do
  runner "Etl::Rosters::HistoricalJob.perform_later"
end

every 1.day, at: '4:40PM' do
  runner "Etl::Players::HistoricalJob.perform_later"
end

every 1.day, at: '4:50PM' do
  runner "Etl::BattingStats::HistoricalJob.perform_later"
end
