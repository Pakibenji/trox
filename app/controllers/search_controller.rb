class SearchController < ApplicationController4
  # l'index permet de faire une recherche sur les outils
  def index
  @query = Tool.ransack(params[:q]) # Ransack permet de faire des recherches sur les outils
  @tools = @query.result(distinct: true) # Résultat de la recherche
  end
end
