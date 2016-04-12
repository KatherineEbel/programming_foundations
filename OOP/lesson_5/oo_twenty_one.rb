require 'pry'

class Player
  attr_accessor :hand
  def initialize
    @hand = []
    # what would the "data" or "states" of  a Player object entail?
      #- maybe cards? a name?
  end

  def show_hand
    hand = "Player hand is: "
    @hand.each { |card| hand << "#{card.name}, "}
    hand
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
  attr_accessor :hand
  def initialize
    @hand = []
    # seems like very similar to Player... do we even need this?
  end

  def show_hand
    "Dealer shows #{@hand.first.name}"
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
    @cards = { hearts: [], diamonds: [], clubs: [], spades: [] }
    @face_cards = ['J', 'Q', 'K', 'A']
    @number_cards = (2..10).to_a
    new_deck
  end

  def new_deck
    @cards.each_key do |suit|
      @face_cards.each { |card| @cards[suit] += [Card.new(suit, card)] }
      @number_cards.each { |card| @cards[suit] += [Card.new(suit, card)] }
    end
  end

  def deal_card
    cards = @cards.values
    suit = cards[rand cards.size]
    card = suit[rand suit.size]
    suit.delete card
  end
end

class Card
  attr_reader :name
  def initialize(suit, name)
    # what are the 'states' of a card?
    @suit = suit
    @name = name
    @value
  end

  def to_s
    name
  end
end

class TwentyOneGame
  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def display_welcome_message
    welcome_message = <<-MSG
      Welcome to the game of 21!
      Beat the dealer to 5 points to win!
      One point for every round you win.
    MSG
    puts welcome_message
  end

  def deal_hands
    2.times do
      @player.hand << @deck.deal_card
      @dealer.hand << @deck.deal_card
    end
  end

  def show_initial_hands
    binding.pry
    puts @dealer.show_hand
    puts @player.show_hand
  end

  def start
    display_welcome_message
    # what's the sequence of steps to execute the game play?
    deal_hands
    show_initial_hands
    # player_turn
    # dealer_turn
    # show_result
  end
end

TwentyOneGame.new.start
