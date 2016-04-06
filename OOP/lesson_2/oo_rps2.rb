# is this design, with Human and Computer sub-classes, better? Why or why not?
# What is the primary improvement of this design?
# What is the primary drawback of this design?
# Better because each subclass of Player contains it's own individual behaviors specific to it's type, and all the Base functionality is defined by the superclass Player. This way if we needed to add more behavior to the basic Player class, it would be easy to implement in the Human and Computer subclasses. Or if we wanted to add more specific functionality to one of the subclasses we wouldn't have to modify anything about the other subclass. To me this is the major improvement that this change provides. The only drawback to me seems to be writing more code, but it is code that makes the program easier to modify in the future.

# what is the primary improvement and drawback of this new design?
# Extracting all the move comparison logic to it's own class simplifies the game class, and makes the game more flexible.

# Scissors cuts Paper covers Rock, crushes Lizard, poisons Spock,
# smashes Scissors, decapitates Lizard, eats Paper, disproves Spock,
# vaporizes Rock, crushes Scissors
# Rock      - crushes Lizard, crushes Scissors
# Paper     - covers Rock, disproves Spock
# Scissors  - cuts Paper, decapitates Lizard
# Lizard    - poisons Spock, eats Paper
# Spock     - smashes scissors, vaporizes Rock

class Player
  attr_accessor :move, :name, :score
  def initialize
    set_name
    @score = 0
  end

  # def set_name
  #   self.name = name
  # end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new Move::VALUES.sample
  end
end

class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors'].freeze
  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    case @value
    when 'rock' then other_move.scissors?
    when 'paper' then other_move.rock?
    when 'scissors' then other_move.paper?
    end
  end

  def <(other_move)
    case @value
    when 'rock' then other_move.paper?
    when 'paper' then other_move.scissors?
    when 'scissors' then other_move.rock?
    end
  end
end

# class Rule
#   def initialize
#     # not sure what the "state" of a rule object should be
#   end
# end

# not sure where "compare" goes yet
# def compare(move1, move2)
#
# end

class RPSGame
  MAX_SCORE = 10
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors #{human.name}! Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def human_win?
    if human.move > computer.move
      human.score += 1
      return true
    end
  end

  def computer_win?
    if human.move < computer.move
      computer.score += 1
      return true
    end
  end

  def display_winner
    if human_win?
      puts "#{human.name} won!"
    elsif computer_win?
      puts "#{computer.name} won!"
    else
      puts "It's a Tie!"
    end
  end

  def display_scores
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def game_over?
    if human.score == RPSGame::MAX_SCORE ||
      computer.score == RPSGame::MAX_SCORE
      puts "Game Over!"
      return true
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer == 'y' ? true : false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_scores
      if game_over?
        play_again? ? reset_scores : break
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play
