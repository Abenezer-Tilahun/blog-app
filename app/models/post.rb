class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_counter

  def update_posts_counter
    @users.each do |user|
      user.update_column(:posts_counter, user.posts.count) if user.id == author_id
    end
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
