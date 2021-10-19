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

  def tag_save(tag_list)
    current_tag_list = self.tags.pluck(:name) unless self.tags.nil?
    old = current_tag_list - tag_list
    new = tag_list - current_tag_list

    old.each do |name|
      self.tags.delete Tag.find_by(name: name)
    end

    new.each do |name|
      game_tag = Tag.find_or_create_by(name: name)
      self.tags << game_tag
    end
  end

  scope :title_autocomplete, ->(word) {
    where("name collate utf8_unicode_ci LIKE :q OR kana collate utf8_unicode_ci LIKE :q",q: "%#{word}%").order(:name, :kana)
  }

end
