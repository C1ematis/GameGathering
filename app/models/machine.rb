class Machine < ApplicationRecord

  has_many :machine_relations, dependent: :destroy
  has_many :games, through: :machine_relations

end
