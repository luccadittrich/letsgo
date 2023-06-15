class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @posts = @post.posts.order(created_at: :desc)
    @new_post = Post.new
  end

  def new
    @event = Event.find(params[:event_id])
    @post = Post.new
  end

  def create
    if request.referrer.include?('home')
      @post = Post.new(post_params)
      @post.user = current_user
      @post.save
      if @post.save
        redirect_to home_path
      else
        render :new
      end
    else
      @event = session[:event]
      @post = Post.new(post_params)
      @post.event_id = @event["id"]
      @post.user = current_user
      @post.save
      if @post.save
        if @post.post.present?
          redirect_to post_path(@post.post)
        else
          redirect_to event_path(@event["id"])
        end
      else
        render :new
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :event_id, :user_id, :post_id, photos: [])
  end
end
