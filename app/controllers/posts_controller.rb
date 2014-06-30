class PostsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    @comment = @post.comments.build
  # generating new comment instance within specific post  
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post
    if @post.save
         redirect_to [@topic, @post], notice: "Post was saved with great success."  
  # same as redirect_to topic_post_url(@topic, @post) 
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end      
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :new
    end
  end   

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end  

end
