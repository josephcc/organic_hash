require 'digest/sha1'

NOUN = ['apple', 'orange']
ADJ = ['amazing','huge']
ADV = ['hugely', 'amazingly']

class OrganicHash

	def initialize(noun = NOUN, adj = ADJ, adv = ADV)
		@noun = noun
		@adj = adj
		@adv = adv
	end

	def hash(hex, length = 2, array = false)
		length = [5, length].min
		indexes = hex2indexes(hex, length)

		output = []
		noun = @noun[indexes.pop % @noun.length]

		while indexes.length >= 2
			adv = @adv[indexes.pop % @adv.length]
			adj = @adj[indexes.pop % @adj.length]
			output << adv
			output << adj
		end

		if indexes.length == 1
			adj = @adj[indexes.pop % @adj.length]
			output << adj
		end

		output << noun

		if not array
			output = output.join('-')
		end
		output
		
	end

	def hex2indexes(hex, length)
		sha1 = Digest::SHA1.hexdigest hex
		seg = sha1.length / length
		rem = sha1.length % length
		indexes = []
		for i in (0...length)
			indexes << sha1[seg*i...seg*(i+1)].to_i(16)
		end
		indexes
	end

end

