class ComentsController < ApplicationController

  def index
    @coments = Coment.find_by(page: request.fullpath)
    session[:url] = request.referer
  end

  def create
    if params[:ancestry] == "root"
      game_coment = Coment.new(coment_params)
      game_coment.ancestry = nil
    else
      coment = Coment.find(params[:ancestry]).children.new(oment_params)
    end
    coment.page = request.fullpath
    coment.save
    session[:url] = request.referer
    redirect_to session[:url]
  end

private

  def coment_params
    params.require(:game_coment).permit(:name, :body)
  end

end
