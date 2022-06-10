class PostsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @post = Post.new
  end

  def create
    @event = Event.find(params[:event_id])
    @post = Post.new(post_params)
    @post.event = @event
    @post.user = current_user
    @post.save
    # no need for app/views/posts/create.html.erb
    if @post.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

    # def destroy
    #   # no need for app/views/posts/destroy.html.erb
    #   @post = Post.find(params[:id])
    #   @post.destroy
    #   redirect_to event_posts_path
    # end

    private
  
    def post_params
      params.require(:post).permit(:content, :photo)
    end
end
