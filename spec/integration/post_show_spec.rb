require 'rails_helper'

RSpec.describe 'Testing posts/show page', type: :feature do
  describe 'current user session test' do
    before(:each) do
      @user1 = User.create(name: 'Abeni', photo: 'photo', bio: 'Dev from ETH.', email: 'Abeni@gmail.com',
                           password: 'Abenisecret', confirmed_at: Time.now, postscounter: 0)
      @user2 = User.create(name: 'Beki', photo: 'photo', bio: 'NTK from ETH.', email: 'Beki@gmail.com',
                           password: 'Bekisecret', confirmed_at: Time.now, posts_counter: 0)
      @user3 = User.create(name: 'Rahel', photo: 'photo', bio: 'Doctor from ETH.', email: 'Rahel@gmail.com',
                           password: 'Rahelsecret', confirmed_at: Time.now, posts_counter: 0)
      @post1 = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user1.id)

      @coment1 = Comment.create(text: ' test comment 1', author_id: @user1.id, post_id: @post1.id)
      @coment2 = Comment.create(text: ' test comment 2', author_id: @user3.id, post_id: @post1.id)
      @coment3 = Comment.create(text: ' test comment 3', author_id: @user2.id, post_id: @post1.id)
      @like = Like.create(author_id: @user2.id, post_id: @post1.id)
      @like = Like.create(author_id: @user1.id, post_id: @post1.id)
      @like = Like.create(author_id: @user2.id, post_id: @post1.id)

      visit user_session_path

      fill_in 'Email',	with: @user1.email
      fill_in 'Password',	with: @user1.password
      click_button 'Log in'

      visit user_post_path(user_id: @user1.id, id: @post1.id)
    end

    scenario 'if user can see own name' do
      expect(page).to have_content 'Abeni'
    end

    scenario 'if user can see post title' do
      expect(page).to have_content 'Testing with capybara'
    end

    scenario 'if user can see post text' do
      expect(page).to have_content 'test for views'
    end

    scenario 'if user can see comments text' do
      expect(page).to have_content 'Comment:'
      expect(page).to have_content 'Rahel: test comment 2'
    end

    scenario 'if user can see posts count' do
      expect(page).to have_content 'Comments : 3'
    end

    scenario 'if user can see likes count' do
      expect(page).to have_content 'Likes : 3'
    end

    scenario 'if page has link' do
      expect(page.has_button?('~Like~')).to be true
    end

    scenario 'if page has link' do
      expect(page.has_button?('Delete')).to be true
    end

    scenario 'if I can see the username of each commentor.' do
      expect(page).to have_content 'Abeni'
      expect(page).to have_content 'Beki'
      expect(page).to have_content 'Rahel'
    end

    scenario 'if I can see the comment each commentor left.' do
      expect(page).to have_content 'test comment 1'
      expect(page).to have_content 'test comment 2'
      expect(page).to have_content 'test comment 3'
    end
  end
end
