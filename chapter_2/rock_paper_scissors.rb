VALID_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'sp' => 'spock', 'l' => 'lizard' }.freeze

scores = { player: 0, computer: 0 }

def prompt(message)
  puts "=> #{message}"
end

def win?(player_1, player_2)
  case player_1
  when 'scissors' then player_2 == 'paper' || player_2 == 'lizard'
  when 'paper' then player_2 == 'rock' || player_2 == 'spock'
  when 'rock' then player_2 == 'lizard' || player_2 == 'scissors'
  when 'lizard' then player_2 == 'spock' || player_2 == 'paper'
  when 'spock' then player_2 == 'scissors' || player_2 == 'rock'
  end
end

def game_over?(scores)
  scores.value? 5
end

def reset(scores)
  scores.each_key { |key| scores[key] = 0 }
end

def update_scores(scores, player, computer)
  if win?(player, computer)
    scores[:player] += 1
  elsif win?(computer, player)
    scores[:computer] += 1
  end
end

def display_result(player, computer)
  if win?(player, computer)
    prompt 'You won!'
  elsif win?(computer, player)
    prompt 'Computer won!'
  else
    prompt "It's a tie!"
  end
end

def valid?(input)
  VALID_CHOICES.key? input
end

welcome_message = <<-MSG
  Welcome to Rock, Paper, Scissors, Lizard, Spock!
  Beat the computer 5 times to win!
MSG
prompt welcome_message
# main play loop
loop do
  choice = ''
  # choose selection loop
  loop do
    prompt 'Pick your choice from:'
    VALID_CHOICES.each_pair do |key, value|
      puts "\t(#{key}) for #{value}"
    end
    choice = gets.chomp

    break if valid? choice
    prompt "That's not a valid choice."
  end

  computer_choice = VALID_CHOICES[VALID_CHOICES.keys.sample]

  puts "You chose: #{VALID_CHOICES[choice]}, Computer chose: #{computer_choice}"

  display_result(VALID_CHOICES[choice], computer_choice)
  update_scores(scores, VALID_CHOICES[choice], computer_choice)
  prompt "Your score: #{scores[:player]}, Computer score: #{scores[:computer]}"

  if game_over?(scores)
    prompt 'Do you want to play again?'
    answer = gets.chomp
    if answer.downcase.start_with? 'y'
      reset(scores)
    else
      break
    end
  end
end

prompt 'Thank you for playing. Good bye!'
