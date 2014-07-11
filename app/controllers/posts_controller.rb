class PostsController < ApplicationController

  before_filter :get_topic

  def show
    authorize @topic
    @post = @topic.posts.find(params[:id])
    @comments = @post.comments 
  # generating new comment instance within specific post  
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
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
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
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

  def destroy
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show  
    end
  end    

  private

  def get_topic
    @topic = Topic.find(params[:topic_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end  

end
