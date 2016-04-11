class Player
  def initialize
    # what would the "data" or "states" of  a Player object entail?
      #- maybe cards? a name?
  end

  def hit

  end

  def stay

  end

  def busted?

  end

  def total
    # definitely looks llike we need to know about "cards" to produce some total
  end
end

class Dealer
  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit

  end

  def stay

  end

  def busted?

  end

  def total

  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

module Hand
  def busted?

  end

  def total

  end
end

class Deck
  def initialize
    # obviously, we need some data structure to keep track of  cards
    # array, hash, something else?
  end

  def deal
    # does the dealer or the deck deal
  end
end

class Card
  def initialize
    # what are the 'states' of a card?
  end
end

class TwentyOneGame

  def display_welcome_message
    welcome_message = <<-MSG
      Welcome to the game of 21!
      Beat the dealer to 5 points to win!
      One point for every round you win.
    MSG
    puts welcome_message
  end

  def start
    display_welcome_message
    break
    # what's the sequence of steps to execute the game play?
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

TwentyOneGame.new.start
