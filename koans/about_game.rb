require 'edgecase'
require 'about_dice_project.rb'
require 'about_scoring_project.rb'
require 'about_turn'
require 'about_player'

class Game
  
  attr_reader :players
  
  def initialize(players)
    @players = Array.new()
    players.each{ |player|
      @players.push(Player.new(player))
    }
    @goal_score = 3000
  end
  
  def play
    round = 1
    while !is_final_round
      play_round
      display_round_scores(round)
      round +=1
    end
    play_final_round
    declare_winner
  end
  
  private 
  
  def declare_winner
    top_score = 0
    @players.each { |player| 
      top_score = player.total_score if player.total_score > top_score
    }
    
    winner = @players.select { |player| player.total_score == top_score}
    if winner.size == 1
      puts "\n"
      puts "Congratulations #{winner[0].name}, You have won the game of greed!"
    elsif winner.size > 1
      "We have a tie! Congratulations #{winner.join(", ")}. You are all winners of the game of greed."
    else
      "Houston, we have a problem.  There were zero winners!  Something is wrong."
    end
    display_scores
  end
  
  def display_round_scores(round_number)
    if is_final_round
      puts "#{@players.select { |player| player.total_score >= @goal_score}[0].name} has reached #{@goal_score}. Time to enter the final, sudden death round.  Current Scores:"
    else
      puts "After round #{round_number.to_s}, our scores are: "
    end
    display_scores
  end
  
  def display_scores
    @players.each { |player| puts "#{player.name}: #{player.total_score}"}
  end
  
  def is_final_round
    @players.select { |player| player.total_score >= @goal_score}.size > 0 
  end
  
  def play_round
    @players.each { |player|
      take_players_turn(player)
      return if player.total_score >= @goal_score
    }
  end
  
  def play_final_round
    @players.each { |player|
      take_players_turn(player)
    }
  end
  
  def take_players_turn(player)
    puts "It's #{player.name}'s turn.  #{player.name}, you currently have #{player.total_score.to_s} points."
    player.start_new_turn
    continue_play = true
    while continue_play
      begin
        player.roll_again
        puts player.name + ": " + player.turn_message
        print "Would you like to roll again? (Y/N) "
        again = gets.chomp
        if again.downcase == "n"
          continue_play = false 
          player.end_turn
        end
      rescue SingleTurnScoreThresholdNotMetError
        puts "Sorry #{player.name}, you must have 300 points before you can stop rolling!  Let's roll again."
        continue_play = true
      rescue ZeroPointRollError
        continue_play = false
        puts player.name + ": " + player.turn_message
      end
    end
  end
  
end

class AboutGame < EdgeCase::Koan
  def test_game_initialize
    my_players = ["Ed", "Amy", "Jack", "Ruby", "Jupiter"]
    greed = Game.new(my_players)
    assert_equal my_players.size, greed.players.size
  end

end