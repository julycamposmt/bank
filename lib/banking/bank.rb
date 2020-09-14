module Banking

	class Bank
		@@overdraft = false

		attr_reader :name
		
		def initialization name
			@name = name
			@accounts = {}
			@clients = []
			@transfers = []
		end


		def createAccount client
			account = Account.new(client, self)
			raise "Account number already exists." unless @accounts[account.number] == nil
			@accounts[account.number] = account
			client.addAccount(account)
			account
		end

		def sendTransfer sourceaccount, destinyaccount, amount
			
			return false if @accounts[sourceaccount.number].nil?

			transfer = Banking::InterBankTransfer.new(sourceaccount, destinyaccount, amount, sourceaccount.bank, "send")

			unless @@overdraft

			  if @accounts[sourceAccount.number].balance < amount
				  raise "Transfer failed. Insufficient balance" 
				end    
			end

			@accounts[sourceaccount.number].removeFounds (amount + Banking::InterBankTransfer.commission)

			begin
				destinyaccount.bank.receiveTransfer sourceaccount, destinyaccount, amount
			rescue
				@accounts[sourceaccount.number].addFounds (amount + Banking::InterBankTransfer.commission)
				raise "Transfer failed. Fate bank errorr"
			end

			@transfers << transfer

		end


		def receiveTransfer sourceaccount, destinyaccount, amount

			raise "Transfer failed" if Random.rand <= 0.3
			
			@accounts[destinyAccount.number].addFounds amount
					
			@transfers << Banking::InterBankTransfer.new(sourceaccount, destinyaccount, amount, destinyaccount.bank, "received")
			
			return true
		
		end

		def internalTransfer sourceaccount, destinyaccount, amount

      if @accounts[sourceaccount.number].nil?
			  raise "Transfer failed. Invalid source account " 
			elsif @accounts[destinyaccount.number].nil?
			  raise "Transfer failed. Invalid destiny account " 
      end 

			unless @@overdraft
				
				if @accounts[sourceaccount.number].balance < amount
				  raise "Transfer failed. Insufficient balance"  
				end   
			end

			@accounts[sourceaccount.number].removeFounds amount
			@accounts[destinyaccount.number].addFounds amount


			@transfers << Banking::IntraBankTransfer.new(sourceaccount, destinyaccount, amount)

			true
		end

		def transfers_history
			@transfers
		end

	end

end