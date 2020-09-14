require 'spec_helper'
require './lib/banking'

describe Banking::Bank do

	before :each do
		@bank          = Banking::Bank.new( "Test_Bank" )
		@client_one    = Banking::Client.new("Test_Client")
		@client_two    = Banking::Client.new("Test_Client")
		@client_three  = Banking::Client.new("Test_Client")
		@other_bank    = Banking::Bank.new( "Other_Bank" )
		@account_one   = @bank.createAccount(@client_one)
		@account_two   = @bank.createAccount(@client_two)
		@account_three = @other_bank.createAccount(@client_three)

	end

	describe 'initialization' do 
		context 'You must create an empty bank' do
			it 'Create a bank' do
				expect(@bank).not_to be_nil
			end

		end
	end

	describe 'createAccount' do 
		context 'Create a account successfully' do
			it 'Creates an account on client' do
				expect(@client_one.accounts).not_to be_empty
			end			

		end
	end

	describe 'internalTransfer' do 
		context 'Issue a transfer between internal accounts' do
			it 'Fails with not enought founds' do
				expect{@bank.internalTransfer @account_one, @account_two, 100}.to raise_error(RuntimeError)
			end
			it 'Success with internal accounts' do
				@account_one.addFounds(100)
				expect(@bank.internalTransfer @account_one, @account_two, 100).to be true
				expect(@account_one.balance).to be 0
				expect(@account_two.balance).to be 100
			end
			it 'Fails with external accounts' do
				expect{@bank.internalTransfer @account_two, @account_three, 100}.to raise_error(RuntimeError)
			end
		end
	end

	describe 'sendTransfer' do 
		context 'SendTransfer' do
			it 'Fails without found' do
				expect{sendTransfer @account_two, @account_three, 100}.to raise_error
			end
			it 'Success with founds' do
				@account_two.addFounds 150
				begin
					@bank.sendTransfer @account_two, @account_three, 100
					expect(@account_two.balance).to be(0)
					expect(@account_three.balance).to be(100)
				rescue 
					expect(@account_two.balance).to be(105)
					expect(@account_three.balance).to be(0)
				end
			end
			
		end
	end

	describe 'receiveTransfer' do 
		context 'You must create an empty bank' do
			it 'receives money sucessfully' do
			
				@account_two.addFounds 250
				begin
					@other_bank.receiveTransfer @account_two, @account_three, 200
					expect(@account_three.balance).to be 200
				rescue
					expect(@account_three.balance).to be 0
				end
			end

			it 'Receives money sucessfully' do

				@account_two.addFounds 250
				begin
					@other_bank.receiveTransfer @account_two, @account_three, 200
					expect(@account_three.balance).to be(200)
				rescue
					expect(@account_three.balance).to be(0)
				end
			end

		end
	end
end
