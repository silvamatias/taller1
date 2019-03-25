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

end 