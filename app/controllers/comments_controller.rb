class CommentsController < ApplicationController
  before_action :guest_log_in, only: %i[ create destroy]

   def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.create(comment_params)
    redirect_to blog_path(@blog)
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_path(@blog)
  end

  private

    def guest_log_in
      redirect_to root_path if current_user.email == 'guest@example.com'
    end

    def comment_params
      params.require(:comment).permit(:body, :commenter)
    end
end
