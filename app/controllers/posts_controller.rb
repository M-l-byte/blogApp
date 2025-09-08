class PostsController < ApplicationController

    before_action:authenticate_user!
    before_action:set_post, only:[:show, :edit, :update, :destroy]
    before_action:authorize_user!, only: [:edit, :destroy, :update]

  def index
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
  end

  def new 
    @post=current_user.posts.build
  end

  def create 
    @post=current_user.posts.build(post_params)
    if @post.save
        redirect_to user_path(current_user), notice: "Post successfully created" 
    else
        render :new   
    end 
  end
  def edit 
  end

  def update 
    if @post.update(post_params)
        redirect_to @post, notice: "Post updated successfully"
    else
        render :edit
    end    
  end
  def destroy 
     redirect_to posts_path,notice: "Post successfully deleted"
  end
  
  private

  def set_post
    @post=Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user!
    redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
  end
end
