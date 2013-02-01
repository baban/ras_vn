# encoding: utf-8

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

# update recipe_food_genre amount column
every 1.hour do
  runner "RecipeFoodGenre.aggrigation"
end

# create today's popular recipe ranking
every 1.day, at:"00:05" do
  runner "RecipeRanking.aggrigation"
end

# create today's popular recipe food ranking
every 1.day, at:"00:10" do
  runner "RecipeFoodRanking.aggrigation"
end

every 1.day, at:"11:00" do
  # runner "MailBuffer.send_mail_buffers"
end

# caliculate today's entry and retire users amount
every 1.day, at:"00:30" do
  runner "EntretResult.aggrigation"
end

every 1.day, at:"01:00" do
  runner "TrackerResult.aggrigation"
end

every 1.hour do
  runner "FacebookFriendInvite.invites"
end

every 1.day, at:"10:00" do
  runner "RecommendRecipeMail.send_mail_magazines"
end

# Learn more: http://github.com/javan/whenever
