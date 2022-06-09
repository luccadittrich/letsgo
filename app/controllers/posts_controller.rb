class PostsController < ApplicationController

    #def show
    #end
    
    def create
      @event = Event.find(params[:event_id])
      @post - Post.new(post_params)
      @post.event = @event
      # no need for app/views/posts/create.html.erb
      @post.user = current_user
      if @post.save
        redirect_to event_path(@event)
      else
        render "events/show"
      end
    end

    # def destroy
    #   # no need for app/views/posts/destroy.html.erb
    #   @post = Post.find(params[:id])
    #   @post.destroy
    #   redirect_to event_posts_path
    # end

    private

    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:description, :photo)
    end
end
