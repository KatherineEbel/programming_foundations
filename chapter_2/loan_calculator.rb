# 3 year 36month loan 15,000 at 7%
# 15000 ( 0.07) / 12) / (1 - (1 + 0.07 / 12) ^-36) = 463.16 / month

# Need
# 1. The loan amount
# 2. The Annual Percentage Rate (APR)
# 3. The Loan duration

# calculate
# 1. monthly interest rate
# 2. loan duration in months

# methods for loan_calc
def prompt(text)
  puts "=> #{text}"
end

def number?(input)
  Float(input) > 0 && !/,/.match(input)
rescue
  prompt 'Sorry, valid input includes only positive whole and decimal numbers.'
end

def calculate_payment(amount, annual_rate, num_payments)
  amount * (annual_rate / 12) / (1 - (1 + annual_rate / 12)**-num_payments)
end

def process_input_for(input_type)
  input = ''
  loop do
    prompt "Please enter the #{input_type}:"
    input = gets.chomp
    break if number? input
  end
  input.to_f
end

# main
prompt 'Welcome to the loan payment calculator!'

loop do
  loan_amount = process_input_for 'loan amount'
  annual_rate = (process_input_for 'Annual Percentage Rate (APR)') / 100
  num_years = (process_input_for 'duration of the loan in years').to_i

  num_payments =  num_years * 12

  monthly_payment = calculate_payment(loan_amount, annual_rate, num_payments)

  prompt "$#{format('%0.2f', monthly_payment)} per month for #{num_years} years"

  prompt 'Would you like to perform another calculation? (Y for yes)'
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
end

prompt 'Thank you for using the loan payment calculator!'
