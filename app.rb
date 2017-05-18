require "sinatra"
require_relative "hangman.rb"
enable :sessions

get "/player_names" do
	erb:index
end
get "/one_player" do
	erb :one_player
end
post "/one_player_name" do
	session[:player1] = params[:player1]
	redirect "/difficulty"
end
post "/difficulty" do
	level = params[:difficulty]
	if level == "difficulty1"
	dictionary = File.readlines("dictionaryeasy.txt").map(&:chomp)
	password = dictionary.sample
	session[:game]=Hangman.new(password)
	redirect "/guessing"
	elsif
	level == "difficulty2" 
	dictionary = File.readlines("dictionarymed.txt").map(&:chomp)
	password = dictionary.sample
	session[:game]=Hangman.new(password)
	redirect "/guessing"
	elsif
	level == "difficulty3"
	dictionary = File.readlines("dictionaryhard.txt").map(&:chomp)
	password = dictionary.sample
	session[:game]=Hangman.new(password)
	redirect "/guessing"
	end
end
get "/difficulty" do
	erb :difficulty, locals: {p1_name: session[:player1]}
end
post "/player_names" do
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
	redirect "/password"
end

get '/password' do
	erb :password, locals: {p1_name: session[:player1], p2_name: session[:player2]}
end
post '/secertword' do 
	password = params[:word]
	session[:game]=Hangman.new(password)
		 redirect "/guessing"
		 
end
get "/guessing" do	
	erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, guesses: session[:game].guessed, message: "Pick A Letter", counter: session[:game].counter, choice: session[:choice]}
end	
post "/guess" do 
		guessletter = params[:letter].upcase
		
		if session[:game].available_guess(guessletter)
			true

			session[:game].update_guessed(guessletter)
			session[:game].make_move(guessletter)
			if session[:game].winner
			redirect "/winner" 
			elsif
				session[:game].loser
			redirect "/loser"
			end	
			redirect "/guessing"
	 	else
	 		erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, guesses: session[:game].guessed, message: "Invalid Guess, Pick Again!", counter: session[:game].counter, choice: session[:choice]}
	 	end
end

get "/loser" do
	erb :loser, layout: :loser, locals:{p1_name: session[:player1], p2_name: session[:player2], counter: session[:game].counter, word: session[:game].password}
 end
 get "/winner" do
 	erb :winner, layout: :winner, locals:{p1_name: session[:player1], p2_name: session[:player2], counter: session[:game].counter, word: session[:game].password}
 end
 get "/" do
 	erb :landing, layout: :landing, locals:{}
 end
 post "/gamechoice" do 
 	session[:choice] = params[:gamechoice]
 	if session[:choice] == "single_player"
 		redirect "/one_player"
 	else
 		session[:choice] == "two_player"
 		redirect "/player_names"
 	end
end												