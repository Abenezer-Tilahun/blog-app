require 'rails_helper'

RSpec.describe User, type: :model do
  @user = User.new(name: 'Abeni', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.',
                   posts_counter: 0)

  before { @user.save }

  it 'validates the presence of the name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'validates the presence of the posts_counter' do
    @user.posts_counter = nil
    expect(@user).to_not be_valid
  end

  it 'validates the numericality of the posts_counter' do
    @user.posts_counter = 'a'
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

  it 'validates the presence of the bio' do
    @user.bio = nil
    expect(@user).to_not be_valid
  end

  it 'validates the presence of the photo' do
    @user.photo = nil
    expect(@user).to_not be_valid
  end

  describe '# Validate all and recent_posts' do
    before(:each) do
      5.times do |i|
        Post.new(title: "Post #{i}", text: "text#{i}", comments_counter: 0, likes_counter: 0, author_id: user.id)
      end
    end

    it 'returns the all posts' do
      @posts = User.all_posts
      expect(@posts).to_eq 5
    end

    it 'returns the last 3 posts' do
      expect(@user.most_recent_posts).to eq(Post.order(created_at: :desc).limit(3))
    end
  end
end
