require 'digest/sha1'

NOUN = ['apple', 'orange']
ADJ = ['amazing','huge']
ADV = ['hugely', 'amazingly']

class OrganicHash

	def initialize(length = 3, noun = NOUN, adj = ADJ, adv = ADV)
		length = [5, length].min
		length = [1, length].max
		@length = length
		@noun = noun
		@adj = adj
		@adv = adv
	end

	def hash(hex, array = false)
		indexes = hex2indexes hex

		output = []

		while indexes.length > 1
			if indexes.length % 2 == 0
				tok = @adj[indexes.pop % @adj.length]
			else
				tok = @adv[indexes.pop % @adv.length]
			end
			output << tok
		end

		output << @noun[indexes.pop % @noun.length]

		if not array
			output = output.join '-'
		end
		output
		
	end

	def hex2indexes(hex)
		sha1 = Digest::SHA1.hexdigest hex
		seg = sha1.length / @length
		rem = sha1.length % @length
		indexes = []
		for i in (0...@length)
			indexes << sha1[seg*i...seg*(i+1)].to_i(16)
		end
		indexes
	end

end

