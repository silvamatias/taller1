class SearchsController < ApplicationController
	include Metodos

  def index

    @search = params["search"]
    if @search.present?
      @lista_res = searching(@search["search"])
    end
  end



end
