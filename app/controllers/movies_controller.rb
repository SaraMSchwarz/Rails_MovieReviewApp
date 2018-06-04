class MoviesController < ApplicationController

  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all.order("created_at DESC")
  end

  def show

  end

  def new
    #builds movies from current user
    @movie = current_user.movies.build
  end

  def create
    @movie = current_user.movies.build(movie_params)

    if @movie.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie.destroy
    #show page does not exist because the movie is gone, thus redirecting to root path
    redirect_to root_path
  end

  private

    def movie_params
      params.require(:movie).permit(:title, :description, :director, :year)
    end

    def find_movie
      @movie = Movie.find(params[:id])
    end
end
