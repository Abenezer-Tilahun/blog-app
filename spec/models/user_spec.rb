require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations for User model and all posts' do
    before(:each) do
      @user = User.new(name: 'Abeni', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.',
                       posts_counter: 0)
      5.times do |i|
        Post.new(title: "Post #{i}", text: "Post #{i} text", comments_counter: 0, likes_counter: 0,
                 author_id: @user.id)
      end
      @posts = Post.where(author_id: @user.id).all
    end

    before { @user.save }

    it 'if there is name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'PostsCounter must be greater than or equal to zero' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end

    it 'PostsCounter must be greater than or equal to zero' do
      @user.posts_counter = 7
      expect(@user).to be_valid
    end

    it 'should return less than 3 posts ' do
      value = @user.recent_posts.length
      expect(value).to be < 3
    end
  end
end
