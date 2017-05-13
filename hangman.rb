class Hangman
	attr_accessor :password, :guessed, :correct_blank, :counter
	
	def initialize(password)
		@password = password.upcase
		@guessed = []
		@correct_blank = blank()
		@counter = 7
	end
	def charcount
			password.length 
	end
	def blank() 
			Array.new(charcount, "_")
	end
	def update_guessed(choice)
		guessed.push(choice)
	end
	def correct_letter?(letter)
		password.include?(letter)
	end
	def correct_index(guessletter)
		password_array=password.split("")
		# p guessletter
		# p password
		password_array.each_with_index do |letter,index_position|
		# p letter
	if letter == guessletter
		 correct_blank[index_position] = guessletter
		 # p correct_blank
		    end
		end
	end
	def available_guess(choice)
		if guessed.count(choice) == 0
			true
		else
			false
		end
	end
	def make_move(guessletter)
		if correct_letter?(guessletter)
			correct_index(guessletter)
		else
			@counter-=1
		end
	end
	def loser 
	counter == 0
	end
	def winner 
		p correct_blank
		if correct_blank.include?("_")
			false 
		else 
			true
		end 
	end
end