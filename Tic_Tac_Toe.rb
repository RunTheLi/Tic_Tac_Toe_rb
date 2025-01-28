module BoardGame
  BoardLine = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [3, 5, 7], [1, 5, 9]
  ]

  class Game
    def initialize(player_one, player_two)
      @board = Array.new(10)
      @current_player_id = 0
      @players = [player_one.new(self, "X"), player_two.new(self, "O")]
      puts "#{current_player.marker} goes first!"
    end

    def play
      loop do
        print_board
        position = current_player.select_position

        place_marker(current_player, position)

        if player_won?(current_player)
          print_board
          puts "#{current_player.marker} wins!"
          return
        elsif board_full
          print_board
          puts "It's a draw!"
          return
        end

        switch_player
      end
    end

    def place_marker(player, position)
      @board[position] = player.marker
    end

    def player_won?(player)
      BoardLine.any? do |line|
        line.all? { |position| @board[position] == player.marker }
      end
    end

    def free_positions
      (1..9).select { |position| @board[position].nil? }
    end

    def board_full
      free_positions.empty?
    end

    def current_player
      @players[@current_player_id]
    end

    def switch_player
      @current_player_id = 1 - @current_player_id
    end

    def print_board
      puts "
       #{@board[1] || '1'} | #{@board[2] || '2'} | #{@board[3] || '3'}
      ---+---+---
       #{@board[4] || '4'} | #{@board[5] || '5'} | #{@board[6] || '6'}
      ---+---+---
       #{@board[7] || '7'} | #{@board[8] || '8'} | #{@board[9] || '9'}
      "
    end
  end

  class Player
    attr_reader :marker

    def initialize(game, marker)
      @game = game
      @marker = marker
    end
  end

  class HumanPlayer < Player
    def select_position
      loop do
        @game.print_board
        print "Player #{@marker}, select a position (1-9): "
        position = gets.chomp.to_i

        return position if valid_position?(position)

        puts "Invalid position. Please choose a free position between 1 and 9."
      end
    end

    private

    def valid_position?(position)
      (1..9).include?(position) && @game.free_positions.include?(position)
    end
  end
end

player_one = BoardGame::HumanPlayer
player_two = BoardGame::HumanPlayer
game = BoardGame::Game.new(player_one, player_two)
game.play
