require 'digest/sha1'

class OrganicHash

  VERSION = "1.0.0"
  DATA_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', 'data'))
  NOUN = File.read(File.join(DATA_DIR, "noun.dat")).split("\n")
  ADJ = File.read(File.join(DATA_DIR, "adj.dat")).split("\n")
  ADV = File.read(File.join(DATA_DIR, "adv.dat")).split("\n")

  def initialize(length = 3, delimiter = "-", hasher = Digest::SHA1, noun = NOUN, adj = ADJ, adv = ADV)
    @length = [1, [5, length].min].max
    @delimiter = delimiter
    @hasher = hasher
    @noun = noun
    @adj = adj
    @adv = adv
  end

  def hash(str, array = false)
    indexes = str2indexes str

    noun_idx = indexes.pop
    adjs, advs = indexes.partition.with_index { |_, i| i.even? }
    adjs = adjs.map { |i| @adj[i % @adj.length] }
    advs = advs.map { |i| @adv[i % @adv.length] }

    output = advs.zip(adjs).flatten + [@noun[noun_idx % @noun.length]]

    array ? output : output.join(@delimiter)
  end

  def self.hash(hex)
    OrganicHash.new.hash(hex)
  end

  private
  def str2indexes(hex)
    sha1 = @hasher.hexdigest hex
    seg = sha1.length / @length
    rem = sha1.length % @length

    0.upto(@length - 1).map { |i| sha1[seg*i...seg*(i+1)].to_i(16) }
  end

end

