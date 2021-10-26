class HomesController < ApplicationController

  def top

  end

  def info
    @coment = Coment.new
    @coments = Coment.where(page: "/info")
  end

  def search
    @word = params[:word]
  end

end
