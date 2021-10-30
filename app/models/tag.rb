class Tag < ApplicationRecord

  has_many :tag_relations, dependent: :destroy
  has_many :games, through: :tag_relations

  scope :tag_autocomplete, ->(word) {
    where("name LIKE :q",q: "%#{word.tr('ぁ-ん','ァ-ン')}%").order(:name)
  }

end
