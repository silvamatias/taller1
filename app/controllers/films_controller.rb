require 'httparty'
require 'pp'
require 'json'



class FilmsController < ApplicationController
	include Metodos

  def index
	response = HTTParty.get('https://swapi.co/api/films', :headers => {'Content-Type' => 'application/json'}).body
	@films = JSON.parse(response)["results"]  	 
  end

  def show
	url = request.original_url
	@id = get_id(url).to_i

	res = HTTParty.get('https://swapi.co/api/films/'+@id.to_s, :headers => {'Content-Type' => 'application/json'}).body
	@film = JSON.parse(res)

	planets_urls = @film["planets"]
	@planets_names = request_urls(planets_urls, "name")


	char_urls = @film["characters"]
	@characters_names = request_urls(char_urls, "name")

	starships_urls = @film["starships"]
	@starships_names = request_urls(starships_urls, "name")


  end


end

