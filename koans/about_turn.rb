require 'edgecase'
require 'about_dice_project.rb'
require 'about_scoring_project.rb'

class Turn
  attr_reader :dice, :turn_score, :number_of_dice, :last_rolled_dice, :roll_score
  
  def initialize
    @dice = Array.new
    @number_of_dice = 5
    @turn_score = 0
    @roll_score = 0
  end
  
  def roll
    dice_set = DiceSet.new
    @roll_score = score(dice_set.roll(@number_of_dice))
    @dice = dice_set.values
    @last_rolled_dice = dice_set.values
    if @roll_score > 0
      @turn_score += @roll_score
      remove_scoring_dice
    end
  end
  
  private 
  
  def remove_scoring_dice
    # I would have liked to re-vamped the scoring method to take advantage of knowing when a die scores, to remove it
    # for the time being, i'm just using the scoring logic to remove dice from the turn as "score" doesn't have a notion
    # of a turn
    @dice = @dice.reject { |die| die == 1 or die ==5 }
    unique_dice = @dice.uniq
    unique_dice.each{ |unique_die|
      if @dice.grep(unique_die).size/3 > 0
        @dice = @dice.reject{ |die| die == unique_die}
      end
    }
    if @dice.size == 0
      @number_of_dice = 5 # they get all 5 dice back to score
    else
      @number_of_dice = @dice.size
    end
  end
end

class AboutTurn < EdgeCase::Koan
  
  def test_turn_initial_values
    my_turn = Turn.new
    assert_equal 5, my_turn.number_of_dice
    assert_equal [], my_turn.dice
    assert_equal 0, my_turn.turn_score
  end
  
  
  def test_scoring_dice_removed_after_scoring_throw_or_no_score
    my_turn = Turn.new
    my_turn.roll
    
    print "Dice rolled: #{my_turn.last_rolled_dice}\n"
    print "Score: #{my_turn.turn_score.to_s}\n"
    print "Dice left: #{my_turn.dice}\n"
    
    # I know I can probably break this out into better, multiple test methods... just not seeing it right now and would need to refactor  This test is testing too much for one test.
    
    if my_turn.turn_score > 0
      if my_turn.dice.size != 0
          assert my_turn.number_of_dice < 5
          assert my_turn.number_of_dice == my_turn.dice.size
      else
          assert my_turn.number_of_dice == 5
          assert my_turn.dice.size == 0
      end
    else
      assert my_turn.number_of_dice == 5
      assert_equal my_turn.number_of_dice, my_turn.dice.size
    end
  end
  
  def test_score_is_accumulating_for_multiple_scoring_rolls
    my_turn = Turn.new
    my_turn.roll
    
    my_score = 0
    my_score = my_turn.turn_score
    print "My First Score: #{my_score}\n"
    while my_score == my_turn.turn_score
      my_turn.roll
      my_score += my_turn.turn_score
    end
    
    assert my_score > 0
    assert my_score > my_turn.turn_score
    
    print "My Total Score: #{my_score}\n"
    print "My Last roll Score: #{my_turn.turn_score}\n"
    
    
  end
  
  def test_cannot_call_private_method # yeah, I know we can call it (or send it a message) if we really wanted to but... we shouldn't
    my_turn = Turn.new
    assert_raise (NoMethodError) do
      my_turn.remove_scoring_dice
    end
  end
end