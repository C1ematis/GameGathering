class GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path
    else
      render show
    end
  end

  def show
    @genres = Genre.all
    @genre = Genre.new
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render show
    end
  end

private

  def genre_params
    params.require(:genre).permit(:name, :body)
  end

end
