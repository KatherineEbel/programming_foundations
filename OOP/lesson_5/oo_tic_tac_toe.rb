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

  def [](key)
    @squares[key]
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

  def winning_key_for(line)
    line.select { |key| @squares[key].unmarked? }.first
  end

  def line_with_two_identical_markers?(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if squares.count(&:unmarked?) == 1 &&
         squares.count { |square| square.marker == marker } == 2
        return line
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

  def ==(other_marker)
    @marker == other_marker
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
  attr_reader :points
  def initialize
    @points = 0
  end

  def to_s
    @points.to_s
  end

  def add_point
    @points += 1
  end

  def reset
    @points = 0
  end
end

class TicTacToePlayer
  @@marker_choices = %w(X O)
  attr_reader :marker
  attr_accessor :score, :name
  def initialize(board)
    set_name
    set_marker
    @board = board
    @score = Score.new
  end

  def self.marker_choices
    @@marker_choices
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

  def set_marker
    mark = nil
    loop do
      puts "Would you like to be X's or O's? (x/o)"
      mark = gets.chomp.capitalize
      break if TicTacToePlayer.marker_choices.include? mark
      puts "Sorry available markers are x or o"
    end
    @marker = TicTacToePlayer.marker_choices.delete mark
  end

  def choose_square
    puts "Choose a square from #{joinor(@board.unmarked_keys)}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if @board.unmarked_keys.include? square
      puts "Sorry, that's not an available square"
    end
    @board[square] = marker
  end
end

class Computer < TicTacToePlayer
  def initialize(board, opponent)
    set_name
    set_marker
    @board = board
    @score = Score.new
    @opponent = opponent
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def set_marker
    @marker = TicTacToePlayer.marker_choices.first
  end

  def choose_square
    # priority offense, then defense, then midddle, then simply random available
    square = choose_offense? ||
             choose_defense? ||
             choose_middle_square? ||
             choose_random_square
    @board[square] = marker
  end

  def choose_offense?
    line = @board.line_with_two_identical_markers?(marker)
    if line
      return @board.winning_key_for(line)
    end
  end

  def choose_defense?
    line = @board.line_with_two_identical_markers?(@opponent.marker)
    if line
      return @board.winning_key_for(line)
    end
  end

  def choose_middle_square?
    squares = @board.squares
    return  squares.key(@board.middle_square) if @board.middle_square.unmarked?
  end

  def choose_random_square
    @board.unmarked_keys.sample
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
    @human = Human.new @board
    @computer = Computer.new @board, @human
    @current_marker = FIRST_TO_MOVE
  end

  def start_game
    display_welcome_message
    clear
  end

  def play_round
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def play
    start_game
    loop do
      display_board
      play_round
      update_scores
      display_result
      if game_over?
        reset_scores
        break unless play_again?
        reset
        display_play_again_message
      end
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

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
    @human.score.points == WINNING_SCORE || @computer.score.points == WINNING_SCORE
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
