class PlanetsController < ApplicationController
		include Metodos

  def show
	url = request.original_url
	@id = get_id(url).to_i


	res = HTTParty.get('https://swapi.co/api/planets/'+@id.to_s, :headers => {'Content-Type' => 'application/json'}).body
	@planet = JSON.parse(res)

	films_urls = @planet["films"]
	@films_titles = request_urls(films_urls, "title")

	char_urls = @planet["residents"]
	@characters_names = request_urls(char_urls, "name")
  end

end
