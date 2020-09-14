require 'spec_helper'
require './lib/banking'

describe Banking::Transfer do

	before :all do
		@transfer = Banking::Transfer.new(1,2,500)
	end
	
	describe 'initialization' do 
		context 'You must make a new transfer' do
			
			it 'Transfer sourceaccount' do
				expect(@transfer.sourceaccount).to be 1
			end
			it 'Transfer destinyaccount' do
				expect(@transfer.destinyaccount).to be 2
			end
			it 'Transfer amount' do
				expect(@transfer.amount).to be 500
			end
		end
	end
	
end