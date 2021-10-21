class GameComentsController < ApplicationController

  def index
    @game = Game.find_by(name: params[:game_name])
  end

  def create
    game = Game.find_by(name: params[:game_name])
    if params[:game_coment][:ancestry] == "root"
      game_coment = game.game_coments.new(game_coment_params)
      game_coment.ancestry = nil
    else
      game_coment = GameComent.find(params[:game_coment][:ancestry]).children.new(game_coment_params)
      game_coment.game_id = game.id
    end
    game_coment.save
    redirect_to game_path(game.name)
  end

private

  def game_coment_params
    params.require(:game_coment).permit(:name, :body)
  end

end
