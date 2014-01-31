require 'digest/sha1'
require 'securerandom'

class OrganicHash

  VERSION = "1.0.1"
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

    output = adjs.zip(advs).map(&:reverse).flatten.reject(&:nil?) + [@noun[noun_idx % @noun.length]]

    array ? output : output.join(@delimiter)
  end

  def rand(array = false)
	  hash SecureRandom.hex, array
  end

  def self.hash(str, array = false)
    OrganicHash.new.hash str, array
  end

  def self.rand(array = false)
    OrganicHash.new.rand array
  end

  private
  def str2indexes(hex)
    sha1 = @hasher.hexdigest hex
    seg = sha1.length / @length
    rem = sha1.length % @length

    0.upto(@length - 1).map { |i| sha1[seg*i...seg*(i+1)].to_i(16) }
  end

end

