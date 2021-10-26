class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role:{ "一般会員": 1, "編集者": 2, "管理者": 3, "マスター": 5}

  def to_param
    name
  end

  has_many :game_favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, uniqueness: true
  validates :birth, presence: true

  scope :search, ->(word) {
    where("name LIKE :q",q: "%#{word}%").order(:name)
  }

end
