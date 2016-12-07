# -*- encoding : utf-8 -*-
require 'discordrb'
require 'pry'

require_relative 'phantom_callables.rb'
bot = Discordrb::Commands::CommandBot.new token: 'MjQ4MjEwNjY3OTg5ODkzMTIy.CyAOEg.r41kJsj-SEV8dyyj7MOOaoSZsNY', client_id: 248210667989893122, prefix: '*'

tokens = []
bot.command :test do |event, username|
  event.respond mastery_page_by_id(summoner_id_by_username(username))
end

#User creation
bot.command :hold do |event, league_name|
  token = rand(123420 .. 983234)
  discord_id = event.user.id
  time_created = Time.now
  user = [discord_id, league_name, token, time_created]
  if league_name.length < 4
    event.respond "Please enter at least 4 characters."
  else
    tokens.each_with_index do |token, index|
      if user[0] == tokens[index][0]
        tokens.delete_at(0)
      end
    end

    tokens << user
    event.respond "Hi #{event.user.name}! Please log into #{league_name} and rename your first rune page to #{token}. After you are done, please type the command *verify #{league_name}."
  end
end

bot.command :verify do |event, league_name|
  discord_id = event.user.id

  event.respond "Congratulations! You are now verified and may participate in SLGs."
end

bot.command :tokens do |event|
  event.respond "#{tokens}"
end

#SLG hosting
bot.command :hostgame do |event|
  event.respond "@here Game is being hosted!"
end

bot.message(with_text: "Hey Bot!") do |event|
  event.respond "Hi, #{event.user.name}!"
end

bot.command :random do |event, min, max|
  rand(min.to_i .. max.to_i)
end
bot.run
