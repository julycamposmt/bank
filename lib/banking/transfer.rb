module Banking

	class Transfer
		
		attr_reader :sourceaccount, :destinyaccount, :amount

		def initialization sourceaccount, destinyaccount, amount 
			@sourceaccount  = sourceaccount
			@destinyaccount = destinyaccount
			@amount         = amount
		end

	end

end