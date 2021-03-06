# frozen_string_literal: true

require_relative 'codebreaker'
require_relative 'codebreaker/ui'
# UI for testing CogeBreaker module
module UserInterface
  game = Codebreaker::Game.new
  result = ''
  @name = false
  UI.help

  loop do
    @name = UI.name unless @name
    UI.start if game.start

    loop do
      user_option = UI.capture_guess(game)
      p game.hint if %w[h help hint].include? user_option
      next unless game.valid?(user_option)
      p result = game.compare_with(user_option)
      break if game.attempts.zero? || result == '++++'
    end

    result == '++++' ? UI.won(@name, game.attempts) : UI.lost
    game.save(@name) if UI.save?
    break unless UI.repeat_game?
  end
  UI.bye
  UI.show(game.score)
end
