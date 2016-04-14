require 'pry'

module Displayable
  def joinor(arr, delimiter=', ', word='or')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.join(delimiter)
  end

  def display(message)
    puts message
  end
end

module TwentyOneHand
  include Displayable
  STAY = 17
  TWENTY_ONE = 21
  attr_reader :cards, :total
  def initialize
    @cards = []
  end

  def hit(deck)
    @cards << deck.deal_card
  end

  def stay?
    total >= STAY
  end

  def busted?
    total > TWENTY_ONE
  end

  def total
    total = 0
    cards.each do |card|
      total += card.value
      if card.ace? && sum > TWENTY_ONE
        total -= 10
      end
    end
    total
  end

  def show_cards
    cards = @cards.map(&:name)
    "#{name}'s Hand -- #{joinor(cards, ', ', 'and')}" + "\n" \
      "Total: #{total}"
  end

  def discard
    @cards = []
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

  def ace?
    name == 'A'
  end

  def value
    case name
    when (2..10) then name
    when 'J', 'Q', 'K' then 10
    when 'A' then 11
    end
  end
end

class Participant
  include TwentyOneHand
  attr_reader :name
  def initialize
    super
    set_name
  end
end

class Player < Participant
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
    end
    @name = n
  end
end

class Dealer < Participant
  def set_name
    @name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def first_card
    "#{name} shows: #{@cards.first.name}"
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

class TwentyOneGame
  include Displayable
  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @deck = Deck.new
  end

  def start
    display welcome_message
    loop do
      # what's the sequence of steps to execute the game play?
      play_round
      display result
      play_again? ? reset : break
    end
    display goodbye_message
  end

  private

  def welcome_message
    <<-MSG
      Welcome to the game of 21!
      Beat the dealer to 5 points to win!
      One point for every round you win.
    MSG
  end

  def play_round
    loop do
      deal_hands
      display initial_hands
      player_turn
      break if @player.busted?
      dealer_turn
      break
    end
  end

  def deal_hands
    2.times do
      @player.hit(@deck)
      @dealer.hit(@deck)
    end
  end

  def initial_hands
    @dealer.first_card.to_s + "\n" + @player.show_cards.to_s
  end

  def player_turn
    answer = nil
    loop do
      break if @player.busted?
      puts "Would you like to hit or stay? (h/s)"
      answer = gets.chomp.downcase
      break unless answer.downcase.start_with? 'h'
      @player.hit(@deck)
      display @player.show_cards
    end
  end

  def dealer_turn
    loop do
      break if @dealer.stay? || @dealer.busted?
      @dealer.hit(@deck)
    end
  end

  def busted_participant
    @player.busted? ? "#{@player.name} busted!" : nil
    @dealer.busted? ? "#{@dealer.name} busted!" : nil
  end

  def player_win?
    return false if @player.busted?
    @dealer.busted? || @player.total > @dealer.total
  end

  def dealer_win?
    return true if @player.busted?
    @dealer.total > @player.total
  end

  def final_result
    if player_win? then "#{@player.name} Won!"
    elsif dealer_win? then "#{@dealer.name} Won!"
    else "It's a tie!"
    end
  end

  def result
    display busted_participant.to_s
    display final_result.to_s
    display final_hands
  end

  def final_hands
    @player.show_cards.to_s + "\n" + @dealer.show_cards.to_s
  end

  def play_again?
    answer = nil
    loop do
      display "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      display "Sorry, please choose (y/n)"
    end
    answer == 'y'
  end

  def reset
    @deck = Deck.new
    discard_hands
  end

  def discard_hands
    @player.discard
    @dealer.discard
  end

  def goodbye_message
    "Thanks for playing Twenty-one! Goodbye!"
  end
end

TwentyOneGame.new.start
