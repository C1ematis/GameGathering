class TagsController < ApplicationController

  def index
    @word = params[:word]
    @tags = Tag.all
  end

  def create
    @game = Game.find(params[:game][:id])
    tag_list = params[:game][:tag_name].split
    current_tag_list = @game.tags.pluck(:name) unless @game.tags.nil?
    $unique = (current_tag_list & tag_list).present? ? "重複するタグがありました" : ""
    new = tag_list - current_tag_list
    new.each do |name|
      game_tag = Tag.find_or_create_by(name: name)
      @game.tags << game_tag
    end
    redirect_to game_path(@game.name)
  end

  def destroy
    @game = Game.find_by(name: params[:game_name])
    @game.tags.delete Tag.find(params[:id])
    redirect_to game_path(@game.name)
  end

private

end
