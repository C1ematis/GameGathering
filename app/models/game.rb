class Game < ApplicationRecord

  def to_param
    name
  end

  has_many :game_favorites, dependent: :destroy
  has_many :game_coments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations
  has_many :machine_relations, dependent: :destroy
  has_many :machines, through: :machine_relations
  has_many :genre_relations, dependent: :destroy
  has_many :genres, through: :genre_relations

end
