class GameFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :game
end
