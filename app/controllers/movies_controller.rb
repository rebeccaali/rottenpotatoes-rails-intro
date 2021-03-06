class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings
    #session[:order] = params[:order]
    #session[:ratings] = params[:ratings]
   #@movies = Movie.all.order(session[:order])
    @order = params[:order]
      
    params[:ratings].nil? ? @ratings = @all_ratings : @ratings = params[:ratings].keys
    @movies = Movie.where(rating: @ratings).order(@order)
      
=begin     
    ratings = params[:ratings] 
    if ratings.nil?
      ratings = Movie.get_ratings 
      
    else
      ratings = ratings
      @movies = Movie.where(rating: ratings)
      #redirect_to movies_path(:order => session[:order], :ratings => ratings)

    end
=end

   
    
    #if !params[:ratings].nil?
    #    selected_ratings = params[:ratings].keys
    #    @movies = Movie.where(rating: selected_ratings)#.order(session[:order])
    #end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
 
end
