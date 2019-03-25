module Metodos
	extend ActiveSupport::Concern

	def get_id(url)
		id = url.split("/")[-1]
		return id
	end 

	def api_request(url)
		response = HTTParty.get(url, :headers => {'Content-Type' => 'application/json'}).body
		res_json = JSON.parse(response)
		id = get_id(url)
		return res_json, id
	end 

	def api_response(res_json, attribute)
		attr_response = res_json["attribute"]
		return
	end

    def request_urls(urls, attribute)
	  	lista_res = []
	  	urls.each do |url|
	  		res_json, id = api_request(url)
	  		needed = [res_json[attribute], id]
	  		lista_res << needed
	  	end
	  	return lista_res
	end 

    def request_urls_single(urls, attribute)
	  		res_json, id = api_request(urls)
	  		needed = [res_json[attribute], id]
	  	return needed
	end 


	def searching(keyword)
		lista_res = []

		res_films = HTTParty.get('https://swapi.co/api/films/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
		films = JSON.parse(res_films)["results"]
		films.each do |film|
			film_id = get_id(film["url"])
			found = [film["title"],film_id,"films"]
			lista_res << found
		end

		res_starships = HTTParty.get('https://swapi.co/api/starships/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
		starships = JSON.parse(res_starships)["results"]
		iterar = JSON.parse(res_starships)["next"]

		starships.each do |starship|
			starship_id = get_id(starship["url"])
			found = [starship["name"],starship_id,"starships"]
			lista_res << found
		end

		while iterar.present?
			res_starships = HTTParty.get(iterar+'/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
			iterar = JSON.parse(res_starships)["next"]
			starships.each do |starship|
				starship_id = get_id(starship["url"])
				found = [starship["name"],starship_id,"starships"]
				lista_res << found
		end
		end

		res_chars = HTTParty.get('https://swapi.co/api/people/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
		chars = JSON.parse(res_chars)["results"]
		iterar = JSON.parse(res_chars)["next"]

		chars.each do |char|
			char_id = get_id(char["url"])
			found = [char["name"],char_id,"characters"]
			lista_res << found
		end

		while iterar.present?
			res_char = HTTParty.get(iterar+'/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
			iterar = JSON.parse(res_chars)["next"]
			chars.each do |char|
				char_id = get_id(char["url"])
				found = [char["name"],char_id,"characters"]
				lista_res << found
		end
		end

		res_planets = HTTParty.get('https://swapi.co/api/planets/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
		planets = JSON.parse(res_planets)["results"]
		iterar = JSON.parse(res_planets)["next"]

		planets.each do |planet|
			planet_id = get_id(planet["url"])
			found = [planet["name"],planet_id,"planets"]
			lista_res << found
		end

		while iterar.present?
			res_planets = HTTParty.get(iterar+'/?search='+keyword.to_s, :headers => {'Content-Type' => 'application/json'}).body
			iterar = JSON.parse(res_planets)["next"]
			planets.each do |planet|
				planet_id = get_id(planet["url"])
				found = [planet["name"],planet_id,"planets"]
				lista_res << found
		end
		end

		return lista_res

	end

end 










