class MoviesController < ApplicationController
  def index
    # VINICIUS STRATEGY
    # for dividing up the query
    # THIS FINDS CHRISTOPHER NOLAN!!!
    #
    # if params[:query].present?
    #   # params[:query] => "christopher nolan"
    #   query_array = params[:query].split(" ")
    #   # query_array => ["christopher", "nolan"]

    #   @movies = Movie.joins(:director).all

    #   query_array.each do |query_word|
    #     sql_query = " \
    #       title @@ :query OR \
    #       syllabus @@ :query OR \
    #       directors.first_name @@ :query OR \
    #       directors.last_name @@ :query
    #     "
    #     if @movies.where(sql_query, query: "%#{query_word}%").any?
    #       @movies = @movies.where(sql_query, query: "%#{query_word}%")
    #     end
    #   end

    # else
    #   @movies = Movie.all
    # end

    if params[:query].present?
      # ILIKE => Case Insensitive
      # sql_query = "title ILIKE ?"
      # sql_query = "title ILIKE ? OR syllabus ILIKE ?"

      # sql_query = " \
      #   (title @@ :query OR \
      #   syllabus @@ :query OR \
      #   directors.first_name @@ :query OR \
      #   directors.last_name @@ :query)
      #   OR
      #   (title ILIKE :query OR \
      #   syllabus ILIKE :query OR \
      #   directors.first_name ILIKE :query OR \
      #   directors.last_name ILIKE :query)
      # "

      # First two work in the same way
      # @movies = Movie.where(title: params[:query])
      # @movies = Movie.where(sql_query, params[:query])

      # @movies = Movie.where(sql_query, "%#{params[:query]}%")
      # @movies = Movie.where(sql_query, "%#{params[:query]}%", "%#{params[:query]}%")
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      # @movies = Movie.search_by_title_and_syllabus(params[:query])
      @movies = Movie.global_search(params[:query])
      # @results = PgSearch.multisearch(params[:query])
    else
      @movies = Movie.all
    end
  end
end
