require "minitest/autorun"
require_relative "hangman.rb"

class Testhangmanfunction < Minitest::Test 
	def test_class_returns_upcase_word
		hangman = Hangman.new("WaTtoN")
		assert_equal("WATTON", hangman.password)
	end
	def test_class_returns_name
		hangman = Hangman.new("WATTON")
		assert_equal(6,hangman.charcount)
	end
	def test_class_returns_six_blanks
		hangman = Hangman.new("WATTON")
		assert_equal(["_","_","_","_","_","_"],hangman.blank)
	end
	def test_class_user_guess_pushed_into_guess_array
		hangman = Hangman.new("WATTON")
		hangman.guessed = ["u", "y", "e"]
		choice ="r"
		assert_equal(["u", "y", "e", "r"],hangman.update_guessed(choice))
	end
	def test_class_user_guessed_correct
		hangman = Hangman.new("WATTON")
		letter ="W"
		assert_equal(true,hangman.correct_letter?(letter))
	end
	def test_class_correct_index_positions
		hangman = Hangman.new("WATTON")
		letter ="W"
		hangman.correct_index(letter)
		assert_equal(["W", "_", "_", "_", "_", "_"],hangman.correct_blank)
	end
	def test_class_correct_index_positions2
		hangman = Hangman.new("WATTON")
		hangman.correct_blank
		letter ="O"
		hangman.correct_index(letter)
		assert_equal(["_", "_", "_", "_", "O", "_"],hangman.correct_blank)
	end
	def test_class_invalid_guess
		hangman = Hangman.new("WATTON")
		letter ="u"
		hangman.correct_index(letter)
		assert_equal(["_", "_", "_", "_", "_", "_"], hangman.correct_blank)
	end
	def test_class_wrong_guess
		hangman = Hangman.new("WATTON")
		hangman.guessed = ["q", "p", "i"]
		choice ="z"
		assert_equal(["q", "p", "i", "z"],hangman.update_guessed(choice))
	end
	def test_class_winner
		hangman = Hangman.new("WATTON")
		hangman.correct_blank = ["W", "A", "T", "T", "O", "N"]
		assert_equal(true,hangman.winner)
	end
	def test_class_winners
		hangman = Hangman.new("WATTON")
		hangman.correct_blank = ["W", "A", "T", "T", "_", "N"]
		assert_equal(false,hangman.winner)
	end
end