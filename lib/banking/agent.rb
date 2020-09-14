module Banking

	class Agent

		def transfer sourceaccount, destinyaccount, amount
		
		  if sourceaccount.bank.nil? || destinyaccount.bank.nil?
			  
			  raise "Account agent error. Invalid accounts " 

			elsif sourceaccount.bank == destinyaccount.bank
				
		    if sourceaccount.balance < amount
				  raise "Account agent error. Insufficient balance in the source account" 
				else
				  sourceaccount.bank.internalTransfer sourceaccount, destinyaccount, amount
        end
			else
				
        commission = Banking::InterBankTransfer.class_variable_get(:@@commission)
				limit      = Banking::InterBankTransfer.class_variable_get(:@@maxLimit)
				
				total_transfers = amount/limit.to_f
				total_comission = commission * total_transfers
				total_amount    = amount + total_comission

        if sourceaccount.balance < total_amount
				  raise "Account agent error. Insufficient balance in the source account" 
        else
					while amount != 0

						amount_to_transfer = (amount > limit ? limit : amount)
						
						begin
							next if sourceaccount.bank.sendTransfer(sourceaccount, destinyaccount, amount_to_transfer)  == false
						rescue
							next
						end
						amount -= amount_to_transfer
					end				 
        end
			end

		end
		
	end

end