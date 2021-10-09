class GamesController < ApplicationController

  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, only:[:index,:show]

  def new

  end

  def create

  end

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

private

  def game_params

  end

end
