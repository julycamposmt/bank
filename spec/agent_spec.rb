require 'spec_helper'
require './lib/banking'

describe Banking::Agent do

	before :each do
		@bank       = Banking::Bank.new( "Test_Bank" )
		@other_bank = Banking::Bank.new( "Other_Bank" )
		@client1    = Banking::Client.new("Test_client1")
		@client2    = Banking::Client.new("Test_client2")
		@account1   = @bank.createAccount(@client1)
		@account2   = @other_bank.createAccount(@client2)
		@account3   = @bank.createAccount(@client2)
	end
	describe 'Transfers' do 

		context 'Transfers between two accounts, same banks' do
			it 'Sucessfull transfer' do
				@account1.addFounds 30000
				Banking::Agent.new().transfer @account1, @account3, 30000
				expect(@account1.balance).to be (30000 - 12000 )
				expect(@account3.balance).to be 12000
			end
			it 'Not enough funds' do
				@account1.addFounds 30000
				expect{Banking::Agent.new().transfer @account1, @account3, 100000}.to raise_error
			end

		end

		context 'Transfers between two accounts, different banks' do
			it 'Sucessfull transfer' do
				@account1.addFounds 30000
				Banking::Agent.new().transfer @account1, @account2, 12000
				expect(@account1.balance).to be (30000 - ( 12000 + (12000/1000.to_f).ceil*5 ) )
				expect(@account2.balance).to be 12000
			end
			it 'Not enough funds' do
				@account1.addFounds 30000
				expect{Banking::Agent.new().transfer @account1, @account2, 12000}.to raise_error
			end

		end

	end
end
