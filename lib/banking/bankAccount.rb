module Banking

	class BankAccount
		@@lastAccountNumber = 0

		attr_reader :balance, :number, :bank

		def initialization client, bank
			@client  = client
			@balance = 0
			@@lastAccountNumber +=1
			@number = @@lastAccountNumber
			@bank   = bank
		end

		def addFounds amount
			@balance += amount
		end

		def removeFounds amount
			@balance -= amount
		end
	end

end