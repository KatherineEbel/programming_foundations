# transformation rules:
# - go through each character:
# - if the character is a space, then tranform it into the
# number of surrounding mines.
# - number of surrounding mines:
#   - assume the current char is at (x, y)
# => the surrounding positions are: (x-1, y-1) (x-1, y)
# => (x-1, y+1), (x,y-1), (x, y+1), (x+y - 1), (x+1, y),
# => (x+1, y+1)
# => count and return number of surrounding positions with character "*"
# - for all other instances not a space char, then keep the same
# character.
require 'pry'
class Board
  def self.transform(input)
    output = Array.new(input.size) { Array.new(input[0].size) }
    input.each_with_index do |row, x|
      row.chars.each_with_index do |char, y|
        if char == ' '
          number_of_mines = number_of_surrounding_mines(x, y, input)
          if number_of_mines == 0
            output[x][y] = ' '
          else
            binding.pry
            output[x][y] = number_of_mines.to_s
          end
        else
          output[x][y] = char
        end
      end
    end
    output.map(&:join)
  end

  def self.number_of_surrounding_mines(x, y, input)
    [input[x-1][y-1], input[x-1][y], input[x-1][y+1], input[x][y-1], input[x][y+1], input[x+1][y-1], input[x+1][y], input[x+1][y+1]].count('*')
  end

  def self.validate_input(input)
    if input.map(&:size).uniq.size != 1
      raise ValueError.new('Input rows have different lengths')
    elsif !input[0].match(/\+-*\+/) || !input[-1].match(/\+-*\+/) || !input[1..-2].all? {|row| row.match(/\|(\ |\*)*\|/) }
      raise ValueError.new('Wrong border or invalid chars')
    end
  end
end


input = ['+------+',
       '| *  * |',
       '|  *   |',
       '|    * |',
       '|   * *|',
       '| *  * |',
       '|      |',
       '+------+']

p Board.transform input

#  out = ['+------+',
#         '|1*22*1|',
#         '|12*322|',
#         '| 123*2|',
#         '|112*4*|',
#         '|1*22*2|',
#         '|111111|',
#         '+------+']
