require 'spec_helper'
require './lib/banking'


describe Banking::BankAccount do

	before :each do
		@account = Banking::BankAccount.new(Banking::Client.new("Test_Client"), "Bank")
	end

	describe 'initialization' do 
		context 'Accounts with different numbers must be created' do
			it 'Validation that the accounts created have different numbers' do
				expect(@account.number).to be Banking::BankAccount.new(Banking::Client.new("Test_Client_Two"), "Bank").number - 1
			end
		end
	end


	describe '.addFounds' do

		context 'You must enter the account balance' do
	  		it 'Add 0' do
	  			@account.addFounds(0)
	    		expect(@account.balance).to be 0
	  		end

	  		it 'Add 250' do
	    		@account.addFounds(250)
	    		expect(@account.balance).to be 250
	  		end
		end
	end

	describe '.balance' do

		context 'You must return the balance of the account' do
	  		it 'Returns balance of a new account, 0' do
	    		expect(@account.balance).to be 0
	  		end
		
	  		it 'Return the balance of account before add 300' do
	    		@account.addFounds(300)
	    		expect(@account.balance).to be 300
	  		end
		
	  		it 'Return the balance of account before add 300 and remove 100' do
	    		@account.addFounds(300)
	    		@account.removeFounds(100)
	    		expect(@account.balance).to be 100
	  		end
		end

	end
end