# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

# I used 4 files to complete this assignment;

# about_turn - based on my initial design, it seemed like the responsibility of keeping the dice and the current throw and all the rules
# associated with a single "turn" belonged to a single class.  I chose to do this versus applying this logic to the player class

# about_player - player class is responsible for an individual player.  It is responsible for owning turns and the rules surrounding a turn.

# about_game - game class is responsible for all the rounds (almost created a round class) and all players actively participarting

# greed.rb - I wanted a generic console app to kick this off, for simplistic reasons (and not knowing ruby's libraries yet) a created some "inline" ruby
# in this module.

# I know I should have more tests on the game class.  Based on how I designed it, building test cases for it seemed challanging
# given that, it should be a sign to refactor the entire greed code base (all 4 files) and make it work more intuitively.
# given the time I've had this project "checked out" I decided to turn in this original version.  It works and will hopefully continue to do so
# after a refactoring session

