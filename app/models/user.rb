class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  validates :name, presence: true
  validates_numericality_of :posts_counter, only_integer: true, greater_than_or_equal_to: 0

  def admin?
    role == 'admin'
  end

  def all_posts
    posts.order(created_at: :desc)
  end
end
