class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_likes_counter

  def update_likes_counter
    @posts.each do |post|
      post.update_column(:likes_counter, post.likes.count) if post.id == post_id
    end
  end
end
