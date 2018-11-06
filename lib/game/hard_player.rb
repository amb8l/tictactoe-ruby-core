module Game
  class HardPlayer
    attr_reader :name, :token

    def initialize(token, name)
      @token = token
      @name = name
    end

    def make_move(game, ui = nil)
      @me = game.current_player
      minimax(game)
      @position
    end

    def minimax(game)
      return score(game) if game.game_over?

      scores = []
      positions = []

      game.available_positions.each do |position|
        g = game.place_token(position)
        scores << minimax(g)
        positions << position
      end

      if game.current_player == @me
        index = scores.select.with_index.max[1]
        @position = positions[index]
        scores[index]
      else
        index = scores.select.with_index.min[1]
        @position = positions[index]
        scores[index]
      end
    end

    def score(game)
      if game.win? && game.last_player == @me
        100
      elsif game.win? && game.last_player != @me
        -100
      else
        0
      end
    end
  end
end