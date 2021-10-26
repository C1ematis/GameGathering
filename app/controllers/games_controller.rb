class GamesController < ApplicationController

  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, except:[:index,:show]

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
    if params[:commit].present?
      @word = params[:word]
      @notword = params[:notword]
      @tags = params[:tags]
      @genres = params[:genre_ids]
      @machines = params[:machine_ids]
      @games = search(@word,@notword,@tags,@genres,@machines).page(params[:page]).per(15)
    elsif params[:title].present?
      @word = params[:word]
      @games = Game.eager_load(:genres, :machines, :tags)
      if @word.present?
        words = @word.split(/[[:blank:]]+/).select(&:present?)
        words.each do |word|
          @games = @games.where("games.name like :q OR kana like :q ", q: "%#{word}%").page(params[:page]).per(15)
        end
      end
    else
        @games = Game.eager_load(:genres, :machines, :tags).page(params[:page]).per(15)
    end
  end

  def show
    @game = Game.preload(:genres, :machines, :tags, :game_favorites, :reviews, :game_coments).find_by(name: params[:name])
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

  def search(word,notword,tag,genres,machines)
    items = Game.includes(:genres, :machines, :tags).references(:genres, :machines, :tags)

    items = items.where(id: MachineRelation.select(:game_id).where(machine_id: machines).group(:game_id).having("COUNT(DISTINCT machine_relations.machine_id) = ?", machines.size)) if machines.present?
    items = items.where(id: GenreRelation.select(:game_id).where(genre_id: genres).group(:game_id).having("COUNT(DISTINCT genre_relations.genre_id) = ?", genres.size)) if genres.present?

    if tag.present?
      tags = tag.split(/[[:blank:]]+/)
      tags_id = Tag.where(name: tags).ids
      items = items.where(id: TagRelation.select(:game_id).where(tag_id: tags_id).group(:game_id).having("COUNT(DISTINCT tag_relations.tag_id) = ?", tags_id.size))
    end

    if word.present?
      words = word.split(/[[:blank:]]+/).select(&:present?)
      words.each do |word|
        tags_id = Tag.where("name like ?", "%#{word}%").ids
        items = items.where("games.name like :q OR kana like :q OR games.body like :q", q: "%#{word}%").or(items.where(id: TagRelation.select(:game_id).where(tag_id: tags_id).group(:game_id)))
      end
    end
    if notword.present?
      notwords = notword.split(/[[:blank:]]+/).select(&:present?)
      notwords.each do |word|
        tags_id = Tag.where("name like ?", "%#{word}%").ids
        items = items.where.not("games.name like :q OR kana like :q OR games.body like :q", q: "%#{word}%").where.not(id: TagRelation.select(:game_id).where(tag_id: tags_id).group(:game_id))
      end
    end

    return items
  end

  def autocomplete_games
    gamestitle = Game.title_autocomplete(params[:word]).pluck(:name).reject(&:blank?)
    render json: gamestitle
  end

private

  def game_params
    params.require(:game).permit(:name, :kana, :body, :cero, :official, :wiki, :day, genre_ids: [], machine_ids: [])
  end

end
