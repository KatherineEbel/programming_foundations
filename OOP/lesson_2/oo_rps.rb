# Rock, Paper, Scissors is a two-player game where each player chooses one of threee possible moves: rock, paper, or Scissors. The chosen moves will then be compared to see who wins, according to the following rules:
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
# If the players chose the same move, ten it's a tie.
# Nouns: player, move, rule
# Verbs: choose, compare
# Player
#   - choose
# Move
# Rule
#
# - compare

class Player
  attr_accessor :move, :name
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
    # maybe a "name"? what about a "move"?
  end

  def set_name
    if human?
      n = nil
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
      end
      self.name = n
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end
  end

  def choose
    if human?
      choice = ''
      loop do
        puts "Please choose rock, paper, or scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end
end

  def human?
    @player_type == :human
  end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock", or "scisssors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = Player.new :human
    @computer = Player.new :computer
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors #{human.name}! Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} Won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} Won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} Won!" if computer.move == 'rock'
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
    return answer == 'y' ? true : false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
