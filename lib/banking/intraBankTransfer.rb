require './lib/banking/transfer'

module Banking

	class IntraBankTransfer < Transfer

		def initialization sourceaccount, destinyaccount, amount 
			@sourceaccount  = sourceaccount
			@destinyaccount = destinyaccount
			@amount         = amount
		end

	end

end