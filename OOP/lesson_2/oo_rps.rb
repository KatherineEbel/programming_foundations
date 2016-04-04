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
  def initialize
    # maybe a "name"? what aabout a "move"?
  end

  def choose

  end
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
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
