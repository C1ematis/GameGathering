class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  scope :search, -> (way,star){
    where("#{way}": star.to_i-0.9..star.to_i) if star.present?
  }

end
