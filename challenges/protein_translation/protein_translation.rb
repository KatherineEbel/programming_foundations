
class InvalidCodonError < StandardError; end
# the Translation class takes codons and translates them into their matching protein.
class Translation
  PROTEINS = { "Methionine" => %w(AUG),
               "Phenylalanine" => %w(UUU UUC),
               "Leucine" => %w(UUA UUG),
               "Serine" => %w(UCU UCC UCA UCG),
               "Tyrosine" => %w(UAU UAC),
               "Cysteine" => %w(UGU UGC),
               "Tryptophan" => %w(UGG),
               "STOP" => %w(UAA UAG UGA) }.freeze

  def self.of_codon(codon)
    PROTEINS.keys.find { |protein| PROTEINS[protein].include? codon }
  end

  def self.of_rna(strand)
    codons = validated strand.chars.each_slice(3).map(&:join)
    remove_stop!(codons).map { |codon| of_codon codon }
  end

  private_class_method

  def self.validated(codons)
    valid = codons.none? { |codon| !PROTEINS.values.flatten.include? codon }
    return codons if valid
    raise InvalidCodonError
  end

  def self.remove_stop!(codons)
    stop_index = codons.detect { |codon| PROTEINS["STOP"].include? codon }
    stop_index ? codons.slice(0, codons.index(stop_index)) : codons
  end
end
