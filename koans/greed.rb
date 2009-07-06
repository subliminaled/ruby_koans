require 'about_game.rb'

puts "Welcome to the game of greed as implemented by Ed Castaneda"
print "How many players are playing today? "
number_of_players = (1..gets.chop.to_i)
players = Array.new
number_of_players.each { |i|
  print "What is the name of player #{i.to_s}? "
  players.push(gets.chop)
}
puts "Great.  Let's play!"
greed = Game.new(players)
greed.play
Process.exit

