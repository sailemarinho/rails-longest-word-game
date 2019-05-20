require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(13)
  end

  def score
    @word = params[:word]
    url = 'https://wagon-dictionary.herokuapp.com/' + @word
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)

    params[:word].split('').select do |letter|
      if params[:letters].include?(letter) && word['found'] == true
        @score = "Congratulations! #{params[:word].upcase} is a valid English word!"
      elsif params[:letters].include?(letter) && word['found'] == false
        @score = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
      elsif params[:letters].include?(letter) == false
        @score = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters]}"
        break
      end
    end
  end
end
