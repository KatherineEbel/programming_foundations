# Rule 1 If a word begins with a vowel sound, add an 'ay'
# sound to the end of the word.

# Rule 2 If a word begins with a consonant sound, move it
# to the end of the word, and then add an 'ay' sound to the
# end of the word.

require 'pry'

def pig_it text
  text.split(' ').each.map do |word|
    # binding.pry
    if word.match /[[:punct:]]/
      word
    else
      word.slice(1..-1) + word.chr + "ay"
    end
  end.join ' '
end

puts pig_it "O tempora o mores !"

# class PigLatin
#   def self.translate(string)
#     string.split(" ").each do |word|
#       if word.scan(/^[aeiou]|^(y|x)[^aeiou]+/).empty?
#         word << word.slice!(/^[^aeiouq]*(qu)*/)
#       end
#       word << "ay"
#     end
#     .join(" ")
#   end
# end

# class PigLatin
#   def self.translate(word)
#     while !start_with_vowel? word
#       first_letter = word.chr
#       word.delete! first_letter
#       word << "#{first_letter}"
#     end
#     word << 'ay'
#   end
#
#   def self.start_with_vowel?(word)
#     word.start_with?('a', 'e', 'i', 'o', 'u', 'y')
#   end
# end

# puts PigLatin.translate 'pig'
# puts PigLatin.translate('chair')
