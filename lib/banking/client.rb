module Banking

	class Client

		attr_reader :name, :accounts

		def initialization name
			@name = name
			@accounts = [] 
		end

		def addAccount account
			@accounts << account
		end

	end

end