# is this design, with Human and Computer sub-classes, better? Why or why not?
# What is the primary improvement of this design?
# What is the primary drawback of this design?
# Better because each subclass of Player contains it's own individual behaviors specific to it's type, and all the Base functionality is defined by the superclass Player. This way if we needed to add more behavior to the basic Player class, it would be easy to implement in the Human and Computer subclasses. Or if we wanted to add more specific functionality to one of the subclasses we wouldn't have to modify anything about the other subclass. To me this is the major improvement that this change provides. The only drawback to me seems to be writing more code, but it is code that makes the program easier to modify in the future.


class Player
  attr_accessor :move, :name
  def initialize
    set_name
    # maybe a "name"? what about a "move"?
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
      n = gets.chomp
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
  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
    @value = value
  end

  def to_s
    self.value
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
    @human = Human.new
    @computer = Computer.new
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

    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a Tie!"
    end

    # case human.move
    # when 'rock'
    #   puts "It's a tie!" if computer.move == 'rock'
    #   puts "#{human.name} won!" if computer.move == 'scissors'
    #   puts "#{computer.name} Won!" if computer.move == 'paper'
    # when 'paper'
    #   puts "It's a tie!" if computer.move == 'paper'
    #   puts "#{human.name} won!" if computer.move == 'rock'
    #   puts "#{computer.name} Won!" if computer.move == 'scissors'
    # when 'scissors'
    #   puts "It's a tie!" if computer.move == 'scissors'
    #   puts "#{human.name} won!" if computer.move == 'paper'
    #   puts "#{computer.name} Won!" if computer.move == 'rock'
    # end
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
