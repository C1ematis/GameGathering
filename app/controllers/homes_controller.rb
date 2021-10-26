class HomesController < ApplicationController

  def top
    @games = Game.eager_load(:genres, :machines).order("games.created_at DESC").limit(5)
    @reviews = Review.last(5)
  end

  def info
    @coment = Coment.new
    @coments = Coment.where(page: "/info")
  end

  def search
    @word = params[:word]
  end

end
