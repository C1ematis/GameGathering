class ComentsController < ApplicationController

  def index
    @coments = Coment.find_by(page: request.fullpath)
    session[:url] = request.referer
  end

  def create
    if params[:coment][:ancestry] == "root"
      coment = Coment.new(coment_params)
      coment.ancestry = nil
    else
      coment = Coment.find(params[:coment][:ancestry]).children.new(coment_params)
    end
    coment.save
    session[:url] = request.referer
    redirect_to session[:url]
  end

private

  def coment_params
    params.require(:coment).permit(:name, :body, :page)
  end

end
