require 'rails_helper'
RSpec.describe Comment, type: :model do
  describe 'Validations For the Comment model' do
    before(:each) do
      @comment = Comment.new(text: 'My first comment', author_id: 1, post_id: 3)
    end

    before { @comment.save }

    it 'if title is present' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'if author_id is integer' do
      @comment.author_id = 'ETH'
      expect(@comment).to_not be_valid
    end

    it 'if post_id is integer' do
      @comment.post_id = 'Abeni'
      expect(@comment).to_not be_valid
    end
  end
end
