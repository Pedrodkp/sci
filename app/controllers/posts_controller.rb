class PostsController < ApplicationController  
	before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
	def index
      if params[:search]
        f = Post.search(params[:search]).order("created_at DESC")
      else
        f = Post.all.order("created_at DESC")
      end
      @posts = f.paginate(:page => params[:page], :per_page => 10)	  
	end

	def show
	  @post = Post.find(params[:id])
	end

	def new
	  @post = current_user.posts.build
	end

	def create
	  @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: @post.title+t(:was_created) }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
	end

	def edit
	end

	def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: @post.title+t(:was_updated) }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end	  
	end

	def destroy
	  @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: @post.title+t(:was_destroyed) }
        format.json { head :no_content }
      end
	end

	private

	def find_post
	  @post = Post.find(params[:id])
	end

	def post_params
	  params.require(:post).permit(:title, :content)
	end 
end
