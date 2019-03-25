class StarshipsController < ApplicationController
		include Metodos

  def show
	url = request.original_url
	@id = get_id(url).to_i


	res = HTTParty.get('https://swapi.co/api/starships/'+@id.to_s, :headers => {'Content-Type' => 'application/json'}).body
	@starship = JSON.parse(res)

	char_urls = @starship["pilots"]
	@characters_names = request_urls(char_urls, "name")

	films_urls = @starship["films"]
	@films_titles = request_urls(films_urls, "title")
  end
end
