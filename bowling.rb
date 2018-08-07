require_relative "game"
require_relative "ui"

class Bowling
  NUM_TURNS = 10

  def initialize
    @ui = UI.new
    @game = Game.new(@ui)
  end

  def play
    @ui.print_welcome_message

    @game.play_turn until @game.game_over?

    @ui.print_end_message(@game.total_score)

    #puts @game.get_running_total
    #puts "Got here"
  end
end

Bowling.new.play
