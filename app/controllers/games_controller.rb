class GamesController < ApplicationController

  # ログイン済ユーザーのみにアクセスを許可する
  #before_action :authenticate_user!, except:[:index,:show]

  def new
    @game = Game.new
    @genres = Genre.all
  end

  def create
    @game = Game.new(game_params)
    tag_list = params[:game][:tag_name].split
    if @game.save
      @game.tag_save(tag_list)
      redirect_to game_path(@game.name)
    else
      render new
    end
  end

  def index
    @word = params[:word]
    @games = Game.eager_load(:genres, :machines, :tags).all
  end

  def show
    @game = Game.find_by(name: params[:name])
    @tag = Tag.new
    @reviews = @game.reviews.limit(5)
    @game_coment = GameComent.new
    @coment = Coment.new
  end

  def update
    @game = Game.find_by(name: params[:name])
    if @game.update(game_params)
      redirect_to game_path(@game.name)
    else
      render show
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :kana, :body, :cero, :official, :wiki, :day, genre_ids: [], machine_ids: [])
  end

end
