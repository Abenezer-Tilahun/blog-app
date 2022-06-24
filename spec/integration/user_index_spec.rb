require 'rails_helper'

RSpec.feature 'Tests for user-index page', type: :feature do
  describe 'user#index' do
    before(:each) do
      @user1 = User.create(name: 'Abeni', photo: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/ea7a3c32163929.567197ac70bda.png',
                           bio: 'Dev from ETH.', email: 'Abeni@gmail.com',
                           password: 'Abenisecret', confirmed_at: Time.now, posts_counter: 0, role: 'admin')
      @user2 = User.create(name: 'Beki', photo: 'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png',
                           bio: 'NTK from ETH.', email: 'Beki@gmail.com',
                           password: 'Bekisecret', confirmed_at: Time.now, posts_counter: 0)

      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user2.id)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user1.id)

      visit user_session_path

      within 'form' do
        fill_in 'Email', with: @user1.email
        fill_in 'Password', with: @user1.password

        click_button 'Log in'
      end
    end

    scenario 'if user see their names and names of other users' do
      expect(page).to have_content 'Abeni'
      expect(page).to have_content 'Beki'
    end

    scenario 'I can see the number of posts each user has written.' do
      expect(page).to have_content 'Posts(1)'
      expect(page).to have_content 'Posts(2)'
    end

    scenario 'if current users can see admin settings if their role is admin' do
      expect(page).to have_content 'admin settings'
    end

    scenario 'I can see the profile picture for each user.' do
      expect(page.first('img')['src']).to have_content 'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png'
    end

    scenario "if I click on a user, I am redirected to that user's show page" do
      click_on 'Abeni', match: :first
      expect(current_path).to eq user_path @user1.id
    end
  end
end
