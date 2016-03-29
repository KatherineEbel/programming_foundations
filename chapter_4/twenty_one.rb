require 'pry'

hands = { 'Player' => [], 'Dealer' => [] }
STAY = 17
TWENTY_ONE = 21

def prompt(message)
  puts "=> #{message}"
end

# Initialize deck
def init_deck
  deck = { hearts: [], diamonds: [], clubs: [], spades: [] }
  deck.each_key do |suit|
    (2..10).each { |value| deck[suit] += [value] }
    ['J', 'Q', 'K', 'A'].each { |value| deck[suit] += [value] }
  end
end

def value_for(card)
  case card
  when (2..10) then card
  when 'J', 'Q', 'K' then 10
  end
end

# calculate aces
def calc_ace_value(current_hand_total)
  current_hand_total >= 10 ? 1 : 11
end

def deal_card(deck)
  cards = deck.values
  suit = cards[rand cards.size]
  card = suit[rand suit.size]
  suit.delete card
end

def sort_aces(hand)
  # sort aces to end of hand for easier calculation
  aces = hand.reject { |card| card != 'A' }
  hand.delete 'A'
  hand << aces
  hand.flatten!
end

def calculate(hand)
  sort_aces(hand) if hand.include?('A')
  sum = 0
  hand.each do |card|
    sum += calc_ace_value(sum) if card == 'A'
    sum += value_for card if card != 'A'
  end
  sum
end

def deal(deck, hands)
  hands.each do |_player, hand|
    2.times { hand << deal_card(deck) }
  end
end

def show(hands)
  prompt "Your hand: #{hands['Player'].join ' '}"
  prompt "Dealer shows: #{hands['Dealer'].first}"
end

def show_total(hand)
  sum = calculate(hand)
  prompt "Your total is: #{sum}"
end

def bust?(hand)
  calculate(hand) > 21
end

def play_again?
  prompt "Play again? (y/n)"
  answer = gets.chomp
  answer.downcase.start_with? 'y'
end

def player_turn(deck, hands)
  hand = hands['Player']
  loop do
    break if bust? hand
    prompt "#{show_total hand}Would you like to 'hit' or 'stay'? (h/s)"
    answer = gets.chomp
    break unless answer.downcase.start_with? 'h'
    hand << deal_card(deck)
    show hands
  end
end

def dealer_turn(deck, hands)
  hand = hands['Dealer']
  loop do
    total = calculate hand
    if total >= STAY || total > calculate(hands['Player']) ||
       total >= TWENTY_ONE
      break
    end
    hand << deal_card(deck)
  end
end

def win?(player_total, dealer_total)
  dealer_total > TWENTY_ONE ||
    player_total <= TWENTY_ONE && player_total > dealer_total
end

def tie?(player_total, dealer_total)
  player_total == dealer_total ||
    player_total > TWENTY_ONE && dealer_total > TWENTY_ONE
end

def calculate_result(hands)
  player_total = calculate hands['Player']
  dealer_total = calculate hands['Dealer']
  return "It's a Tie!" if tie?(player_total, dealer_total)
  win?(player_total, dealer_total) ? "You Won!" : "Sorry, You Lost!"
end

def display_results(hands)
  prompt "Dealer had: #{hands['Dealer'].join(' ')}" \
         " You had: #{hands['Player'].join(' ')}"
  result = calculate_result(hands)
  prompt result
end

def reset(hands)
  hands.each_key { |player| hands[player] = [] }
end

loop do
  deck = init_deck
  deal(deck, hands)
  loop do
    show hands
    player_turn(deck, hands)
    dealer_turn(deck, hands)
    display_results hands
    break
  end
  break unless play_again?
  reset hands
end

prompt "Thanks for playing 21!"
