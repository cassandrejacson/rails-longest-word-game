require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |el|
      el = ('A'..'Z').to_a.sample
      @letters << el
    end
    session[:letters] = @letters
  end

  def fund(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    open_url = open(url).read
    api = JSON.parse(open_url)
    if api['found'] == true
      return true
    end
  end

  def score
    @letters = session[:letters]
    @word = params[:word].upcase
    @results
    array_of_letters = @word.split('')
    array_of_letters.each do |letter|
      if @letters.include?(letter) == false
        @results = "Sorry but #{@word} can't be built with #{@letters.join(" , ")}"
      elsif fund(@word) == true
        @results = "Congratulations #{@word} is a valid word!"
      else
        @results = "sorry but #{@word} is not an English word!"
      end
    end
  end
end
