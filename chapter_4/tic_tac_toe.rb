require 'pry'

INIT_MARK = ' '.freeze
PLAYER_MARK = 'X'.freeze
COMP_MARK = 'O'.freeze
WIN = [[1, 2, 3], [1, 4, 7], [1, 5, 9],
       [4, 5, 6], [2, 5, 8], [3, 5, 7],
       [7, 8, 9], [3, 6, 9]].freeze

scores = { 'Player' => 0, 'Computer' => 0 }
current_player = COMP_MARK

def joinor(array, last_delimeter)
  string = ''
  array.each do |item|
    string += if item == array.last
                "#{last_delimeter} #{item}"
              else
                "#{item}, "
              end
  end
  string
end

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/AbcSize
def display(brd)
  system 'clear'
  puts "You are: #{PLAYER_MARK}'s, and Computer is: #{COMP_MARK}'s"
  puts ""
  puts "      |      |"
  puts "  #{brd[1]}   |  #{brd[2]}   |  #{brd[3]}"
  puts "      |      |"
  puts "-------------------"
  puts "      |      |"
  puts "  #{brd[4]}   |  #{brd[5]}   |  #{brd[6]}"
  puts "      |      |  "
  puts "-------------------"
  puts "      |      |"
  puts "  #{brd[7]}   |  #{brd[8]}   |  #{brd[9]}"
  puts "      |      |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIT_MARK }
  new_board
end

def start_game(current_player)
  prompt 'Would you like to move first? (y/n)'
  answer = gets.chomp
  if answer.downcase.start_with? 'y'
    switch_player current_player
  else
    return current_player
  end
end

def place_piece!(board, current_player)
  case current_player
  when COMP_MARK then computer_turn!(board)
  when PLAYER_MARK then player_turn!(board)
  end
end

def switch_player(current_player)
  if current_player == COMP_MARK
    return PLAYER_MARK
  elsif current_player == PLAYER_MARK
    return COMP_MARK
  end
end

def available_squares(board)
  board.keys.select { |num| board[num] == INIT_MARK }
end

def board_full?(board)
  available_squares(board).empty?
end

def player_turn!(board)
  square = INIT_MARK
  loop do
    available = available_squares(board)
    prompt "Choose a square (#{joinor(available, 'or')})"
    square = gets.chomp.to_i
    break if available_squares(board).include? square
    prompt 'Sorry, that square is not available.'
  end
  board[square] = PLAYER_MARK
end

def computer_turn!(board)
  # priority offense, then defense, then simply random available
  square = computer_offense?(board) ||
           computer_defense?(board) ||
           pick_middle?(board) ||
           available_squares(board).sample
  board[square] = COMP_MARK
end

# AI for computer selections
def eval_state(board, mark)
  WIN.each do |line|
    # find line with 2 player marks
    next unless board.values_at(*line).count(mark) == 2
    square = line.select { |value| board[value] == " " }
    # returns corresponding square number on board
    return square.first
  end
  false
end

def pick_middle?(board)
  middle = 5
  if available_squares(board).include? middle
    return middle
  end
end

def computer_defense?(board)
  # if player has two markers on a winning line mark the third one
  eval_state(board, PLAYER_MARK)
end

def computer_offense?(board)
  # if computer has two markers on a winning line mark the third one
  eval_state(board, COMP_MARK)
end

def won?(board)
  !!winner?(board)
end

def winner?(board)
  WIN.each do |line|
    if board.values_at(*line).count(PLAYER_MARK) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMP_MARK) == 3
      return 'Computer'
    end
  end
  nil
end

def update(scores, board)
  if won?(board)
    scores[winner?(board)] += 1
  end
end

def show(scores)
  prompt "Your score: #{scores['Player']} Computer score: #{scores['Computer']}"
end

def round_over(board, scores)
  if won?(board)
    prompt "#{winner?(board)} won!"
    update(scores, board)
  else
    prompt "It's a tie!"
  end
  show scores
end

def continue?(scores)
  if game_over? scores
    prompt "Game Over! Would you like to play another match? (Y)"
    reset scores
  else
    prompt "Round Over! Would you like to continue? (Y)"
  end
  answer = gets.chomp
  answer.downcase.start_with? 'y'
end

def game_over?(scores)
  scores.value? 5
end

def reset(scores)
  scores = scores.each_key { |player| scores[player] = 0 }
end

# -----------------------------------------
# main game
prompt "Let's play Tic-Tac-Toe! Best out of 5 games wins!"

# main loop
loop do
  board = initialize_board
  current_player = start_game current_player

  # round loop
  loop do
    display(board)
    place_piece! board, current_player
    current_player = switch_player current_player
    break if won?(board) || board_full?(board)
  end

  display(board)
  round_over(board, scores)
  break unless continue?(scores)
end

prompt "Thanks for playing!"
