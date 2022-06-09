require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get '/users/1/posts' }
    it 'respond with message success' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders index view' do
      expect(response).to render_template(:index)
    end
    it 'renders correct content' do
      expect(response.body).to include('Posts of a given user')
    end
  end

  describe 'GET /show' do
    before(:example) { get '/users/1/posts/2' }
    it 'respond with message success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end

    it 'renders correct content' do
      expect(response.body).to include('Specific post of a user')
    end
  end
end
