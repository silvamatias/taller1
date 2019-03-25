class CharactersController < ApplicationController
		include Metodos

  def show
	url = request.original_url
	@id = get_id(url).to_i


	res = HTTParty.get('https://swapi.co/api/people/'+@id.to_s, :headers => {'Content-Type' => 'application/json'}).body
	@character = JSON.parse(res)


	planets_urls = @character["homeworld"]
	@planets_names = request_urls_single(planets_urls, "name")

	starships_urls = @character["starships"]
	@starships_names = request_urls(starships_urls, "name")

	films_urls = @character["films"]
	@films_titles = request_urls(films_urls, "title")
  end

end
