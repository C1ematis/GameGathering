class ReviewsController < ApplicationController

  def new
    @game = Game.find_by(name: params[:game_name])
    @review = Review.new
  end

  def create
    game = Game.find_by(name: params[:game_name])
    review = current_user.reviews.new(review_params)
    review.game_id = game.id
    review.story = 0.5 if review.story.blank?
    review.system = 0.5 if review.system.blank?
    review.total = 0.5 if review.total.blank?
    review.save
    redirect_to game_path(game.name)
  end

  def index
    @game = Game.find_by(name: params[:game_name])
    if params[:commit].present?
      @reviews = @game.reviews.search(params[:way],params[:star])
    else
      @reviews = @game.reviews
    end
  end

private

  def review_params
    params.require(:review).permit(:body, :hour, :story, :system, :total, :is_spoiler)
  end

end