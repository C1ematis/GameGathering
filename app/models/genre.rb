class Genre < ApplicationRecord

  has_many :genre_relations, dependent: :destroy
  has_many :games, through: :genre_relations

end
