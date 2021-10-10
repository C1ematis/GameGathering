class HomesController < ApplicationController

  def top

  end

  def info

  end

  def search
    @word = params[:word]
  end
end
