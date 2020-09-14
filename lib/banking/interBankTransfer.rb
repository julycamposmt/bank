require './lib/banking/transfer'

module Banking

	class InterBankTransfer < Transfer
		@@maxLimit = 1000
		@@commission = 5

		def self.commission
			@@commission
		end

		def self.maxLimit
			@@maxLimit
		end
		
		def initialization  sourceaccount, destinyaccount, amount, bank, type
			if amount > @@maxLimit
			  raise "Error in the Inter Bank Transfer mode. These transfers have a maximum limit of 1000." 
			end 
			super sourceaccount, destinyaccount, amount
			@bank = bank
			@type = type
			@commission = @@commission
		end

	end

end