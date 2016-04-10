# 1. Write a description of the problem and extract the major nouns and verbs
# 2. Make an initial guess at organizing the verbs into nouns and do a spiketo explore the problem with temporary code.
# 3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards

# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turnsmarking squares with x's and o's. The first player to mark 3 in a row either horizontally vertically or diagonally wins. If no one gets three in a row, the game is a draw.
# Nouns: board, player, square, grid
# Verbs: play, mark
# Board
# Square
# Player
# - mark
# - play

module Join
  def joinor(arr, delimiter=', ', word='or')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.join(delimiter)
  end
end
require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                   [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
                   [1, 5, 9], [3, 5, 7]].freeze     # diagonals
  attr_reader :squares
  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def middle_square
    @squares[5]
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers? squares
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def two_identical_markers?
    WINNING_LINES.each do |line|
        next unless @squares.values_at(*line).count(&:marked?) == 2
        markers = @squares.values_at(*line).collect(&:marker)
        if markers.uniq.size == 2
          square = line.select { |value| @squares[value].unmarked? }
          # returns corresponding square number on board
          return square.first
        end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '.freeze
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Score
  def initialize
    @points = 0
  end

  def to_s
    "#{@points}"
  end

  def add_point
    @points += 1
  end

  def reset
    @points = 0
  end
end

class TicTacToePlayer
  attr_reader :marker
  attr_accessor :score, :name
  def initialize(marker, board)
    set_name
    @board = board
    @marker = marker
    @score = Score.new
  end
end

class Human < TicTacToePlayer
  include Join
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
    end
    @name = n
  end

  def choose_square
    puts "Choose a square from #{joinor(@board.unmarked_keys)}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if @board.unmarked_keys.include?(square)
      puts "Sorry, that's not an available square"
    end
    @board[square] = marker
  end
end

class Computer < TicTacToePlayer
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose_square
    square = choose_strategy
    @board[square] = marker
  end

  def choose_strategy
    find_two_in_a_row? ||
    choose_middle? ||
    choose_random_square
  end

  def find_two_in_a_row?
    @board.two_identical_markers?
  end

  def choose_random_square
    # priority offense, then defense, then simply random available
    @board.unmarked_keys.sample
  end

  # AI for computer selections

  def choose_middle?
    middle_square = @board.unmarked_keys.select {|key| @board.squares[key] == @board.middle_square }.first
    return middle_square ? middle_square : nil
  end
end

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER
  WINNING_SCORE = 5
  attr_reader :board, :human, :computer
  def initialize
    @board = Board.new
    @human = Human.new HUMAN_MARKER, @board
    @computer = Computer.new COMPUTER_MARKER, @board
    @current_marker = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    clear
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      update_scores
      display_result
      if game_over?
        reset_scores
        break unless play_again?
          reset
          display_play_again_message
      else
        break unless play_again?
        reset
        display_play_again_message
      end
    end

    display_goodbye_message
  end

  private

  def get_player_name

  end

  def get_computer_name

  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!" + "\n"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{@human.name} is #{@human.marker}'s. #{@computer.name} is #{@computer.marker}'s"
    puts ""
    board.draw
    puts ""
  end

  def display_result
    clear_screen_and_display_board
    puts "Current score is #{@human.name}: #{@human.score}, #{@computer.name}: #{@computer.score}"
    case board.winning_marker
    when HUMAN_MARKER then puts "You Won!"
    when COMPUTER_MARKER then puts "Computer Won!"
    else puts "It's a Tie!"
    end
  end

  def update_scores
    case board.winning_marker
    when HUMAN_MARKER then @human.score.add_point
    when COMPUTER_MARKER then @computer.score.add_point
    end
  end

  def reset_scores
    @human.score.reset
    @computer.score.reset
  end

  def game_over?
    @human.score == WINNING_SCORE || @computer.score == WINNING_SCORE
  end

  def current_player_moves
    if human_turn?
      @human.choose_square
      @current_marker = COMPUTER_MARKER
    else
      @computer.choose_square
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
