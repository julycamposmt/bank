require 'spec_helper'
require './lib/banking'

describe Banking::Agent do

	before :each do
		@bank          = Banking::Bank.new( "Test_Bank" )
		@client_one    = Banking::Client.new("Test_Client_One")
		@client_two    = Banking::Client.new("Test_Client_Two")
		@other_bank    = Banking::Bank.new( "Other_Bank" )
		@account_one   = @bank.createAccount(@client_one)
		@account_two   = @bank.createAccount(@client_two)
		@account_three = @other_bank.createAccount(@client_two)
	end
	describe 'Transfers' do 

		context 'Transfers between two accounts, same banks' do
			it 'Sucessfull transfer' do
				@account_two.addFounds 30000
				Banking::Agent.new().transfer @account_two, @account_one, 30000
				expect(@account_two.balance).to be (30000 - 12000 )
				expect(@account_one.balance).to be 12000
			end
			it 'Not enough funds' do
				@account_two.addFounds 30000
				expect{Banking::Agent.new().transfer @account_two, @account_one, 100000}.to raise_error
			end

		end

		context 'Transfers between two accounts, different banks' do
			it 'Sucessfull transfer' do
				@account_one.addFounds 30000
				Banking::Agent.new().transfer @account_one, @account_three, 12000
				expect(@account_one.balance).to be (30000 - ( 12000 + (12000/1000.to_f)*5 ) )
				expect(@account_three.balance).to be 12000
			end
			it 'Not enough funds' do
				@account_one.addFounds 30000
				expect{Banking::Agent.new().transfer @account_one, @account_three, 12000}.to raise_error
			end

		end

	end
end
