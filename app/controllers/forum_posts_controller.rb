# controls the page that will display all the forum_posts for all users

class ForumPostsController < ApplicationController
    before_action :find_forum_post, only: [:show, :edit, :update, :destroy]
    def index
    end

    def new
     @forum_post = ForumPost.new
    end

    def create
     @forum_post = ForumPost.new(forum_post_params)

     if @forum_post.save
        redirect_to @forum_post
       else
        render 'new'
       end
    end

    def show
    end

    def edit
    end

   def update
     if @forum_post.update(forum_post_params)
      redirect_to @forum_post
     else
      render 'edit'
     end
    end

   def destroy
     @forum_post.destroy
     redirect_to root_path
    end

   private

    def forum_post_params
     params.require(:forum_post).permit(:title, :content)
    end

    def find_forum_post
        @forum_post = ForumPost.find(params[:id])
       end
end