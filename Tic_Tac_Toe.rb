module Boardame 
  BoardLine = [[1,2,3],[4,5,6],[7,8,9],[1,4,7].[2,5,8],[3,6,9],[3,5,7],[1,5,9]] 
  
  class Game
    attr_reader :player_id
    
    def initialize(player_one, player_two)
      @board = Array.new(10)
      @player_id = 0
      @players = [player_one.new(self, 'X'), player_two.new(self, 'O')]
      puts "#{current_player} choose first"
    end

    def play
      loop do
        place_marker(current_player)

        if player_won?(current_player)
          puts "#{current_player} wins"
          print_board
          return
        elsif board_full
          puts "It's a draw"
          print_board
          return
      end

      switch_player
    end
  end
## def print board
## def player_won
## def switch_player
    def place_marker(player)
      position = plyer.select_position!
      puts "#{player} selects #{player.marker} position #{position}"
      @board[position] = player.marker
      end

    def determin_winner
      BoardLine.any? do |line|
        line.all? {|position| @board[position] == player.marker}
      end
    end

    def free_position
      (1..9).select {|position| @board[position].nil?}
    end

    def board_full
      
    end

    def opponent
      @players[other_player_id]
    end 

    def current_player
      @players[current_player_id]
    end
  end
end