require 'spec_helper'
require './lib/banking'

describe Banking::Client do

	before :each do
		@client = Banking::Client.new("Test_Client")
	end

	describe 'initialization' do 
		context 'You must enter a new Client' do
			it 'Client with Test_client name' do
				expect(@client.name).to eq "Test_Client"
			end
			it 'Client without accounts' do
				expect(@client.accounts).to be_empty
			end
		end
	end

	describe '.addAccount' do 
		context 'You must add a account to a client' do
			it 'Add only one account to a client' do
				bank = Banking::Bank.new("Test_Bank")
				account = bank.createAccount(@client)
				expect(@client.accounts).to include(account)
			end
		end
	end
	
end