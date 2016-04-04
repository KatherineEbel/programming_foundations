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
  attr_reader :move
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    # maybe a "name"? what about a "move"?
  end

  def choose
    if human?
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
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks fo playing Rock, Paper, Scissors"
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play
