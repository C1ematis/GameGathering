class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role:{"マスター": 5, "管理者": 3, "編集者": 2, "一般会員": 1}

  def to_param
    name
  end

  has_many :game_favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, uniqueness: true
  validates :birth, presence: true
end
