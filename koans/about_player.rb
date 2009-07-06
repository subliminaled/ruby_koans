require 'edgecase'
require 'about_dice_project.rb'
require 'about_scoring_project.rb'
require 'about_turn'

class Player
  attr_reader :total_score, :name, :turn_message
  
  def initialize(name)
    @total_score = 0
    @name = name
  end
  
  def start_new_turn
    if !@my_turn.nil?
      raise InTurnError.new("You cannot start a new turn without ending your current one.")
    end
    @my_turn = Turn.new
  end
  
  def roll_again
    if @my_turn.nil?
      raise NotYourTurnError.new("It's not your turn! Start a new turn to roll again.")
    end
    roll
  end
  
  def end_turn
    if @my_turn.nil?
      raise NotYourTurnError.new("It's not your turn! You can't end a turn until you start a new one.")
    end    
    if @total_score + @my_turn.turn_score < 300
      raise SingleTurnScoreThresholdNotMetError.new("You must achieve 300 points in a single turn and you only have #{@my_turn.turn_score.to_s} current points.")
    end
    @total_score += @my_turn.turn_score
    @my_turn = nil
  end
  
  def turn_score
    if @my_turn.nil? 
      raise NotYourTurnError.new("You don't have a turn score, it's not your turn!")
    else
      return @my_turn.turn_score
    end
  end
  
  def current_dice
    if @my_turn.nil?
      raise NotYourTurnError.new("You don't have any dice, it's not your turn!")
    else
      @my_turn.dice
    end
  end
  
  private
  
  def roll
    @my_turn.roll
    if @my_turn.roll_score == 0
      lose_turn
    else
      set_turn_message_from_roll
    end
  end
  
  def lose_turn
    @my_turn = nil
    @turn_message = "Your last roll was zero points.  You have lost your turn and all points accumulated for the turn."
    raise ZeroPointRollError.new(@turn_message)
  end
  
    def set_turn_message_from_roll
      if @my_turn.nil?
        @turn_message = "It's not your turn."
      else
        @turn_message = "You rolled #{@my_turn.last_rolled_dice}, have a total turn score of #{@my_turn.turn_score}, leaving #{@my_turn.number_of_dice} dice left to roll."
      end
  end
 
end

class ZeroPointRollError < StandardError
end

class SingleTurnScoreThresholdNotMetError < StandardError
end

class NotYourTurnError < StandardError
end

class InTurnError < StandardError
end

class AboutPlayer < EdgeCase::Koan
  
  def test_player_initialize
    ed = Player.new("Ed")
    assert_equal 0, ed.total_score
  end
  
  def test_player_cant_roll_again_without_starting_a_turn
    ed = Player.new("Ed")
    assert_raise (NotYourTurnError) do
      ed.roll_again
    end
  end
  
  def test_player_cant_end_turn_without_starting_a_turn
    ed = Player.new("Ed")
    assert_raise (NotYourTurnError) do
      ed.end_turn
    end
  end
  
  def test_player_has_no_dice_if_not_in_turn
    ed = Player.new("Ed")
    assert_raise (NotYourTurnError) do
      ed.current_dice
    end    
  end
  
  def test_player_has_no_turn_score_if_not_in_turn
    ed = Player.new("Ed")
    assert_raise (NotYourTurnError) do
      ed.turn_score
    end    
  end
  
  def test_player_can_roll_again_in_turn
    ed = Player.new("Ed")
    ed.start_new_turn
    print ed.turn_message
    assert_nothing_raised do
      begin
        ed.roll_again
      rescue ZeroPointRollError
        # do nothing, swallow
      end
      print ed.turn_message
    end
    
  end
  
  def test_player_can_end_turn_in_turn
    ed = Player.new("Ed")
    ed.start_new_turn
    print ed.turn_message
    print "\n"
    while ed.turn_score < 300 do
      begin
        ed.roll_again
      rescue ZeroPointRollError
       ed.start_new_turn
      end
      print ed.turn_message
      print "\n"
    end
    
    assert_nothing_raised do
      ed.end_turn
    end
    
  end
  
  def test_player_has_dice_in_turn
    ed = Player.new("Ed")
    ed.start_new_turn
    print ed.turn_message
    assert_nothing_raised do
      ed.current_dice
      print ed.current_dice
    end
  end
  
  def test_player_has_turn_score_in_turn
    ed = Player.new("Ed")
    ed.start_new_turn
    print ed.turn_message
    assert_nothing_raised do
      ed.turn_score
      print ed.turn_score
    end    
  end
  
  def test_player_cannot_start_new_turn_without_ending_current
    ed = Player.new("Ed")
    ed.start_new_turn
    assert_raise (InTurnError) do
      ed.start_new_turn
    end
  end
  
  def test_player_cannot_end_first_turn_without_reaching_300
    ed = Player.new("Ed")
    ed.start_new_turn
    if ed.turn_score < 300
      assert_raise (SingleTurnScoreThresholdNotMetError) do
        ed.end_turn
      end
    end #if we score 300 in first roll, nice.  Not going to check for that

  end
end

