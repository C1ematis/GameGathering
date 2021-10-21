class GameFavoritesController < ApplicationController

  def create
    @game = Game.find_by(name: params[:game_name])
    favorite = current_user.game_favorites.new(game_id: @game.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @game = Game.find_by(name: params[:game_name])
    favorite = current_user.game_favorites.find_by(game_id: @game.id)
    favorite.destroy
    # redirect_to request.referer
  end

end
