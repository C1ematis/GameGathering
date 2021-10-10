class Tag < ApplicationRecord

  has_many :tag_relations, dependent: :destroy
  has_many :games, through: :tag_relations

end
