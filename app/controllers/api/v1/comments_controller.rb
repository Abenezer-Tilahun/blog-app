module Api
  module V1
    class CommentsController < ApiController
      def index
        @comments = Post.find(params[:post_id]).comments
        render json: @comments
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:text, :author_id).with_defaults(author_id: 1)
      end
    end
  end
end
