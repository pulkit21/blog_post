class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :published, :unpublished, :update, :destroy]
  before_action :authenticate_user!, :except =>[:index, :show]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.published
    if params[:search].present?
      @posts = @posts.where("title like :search OR body like :search OR post_path like :search", search: "%#{params[:search]}%")
    else
      @posts
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_to @post, notice: 'Not an authorized user'  if !@post.users_post(current_user)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      post_params[:published_at] = Time.zone.parse(post_params[:published_at]) if post_params[:published_at].present?
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def blog_posts
    @posts = current_user.posts
  end

  def published
    if @post.users_post(current_user)
      @post.publish!
      redirect_to blog_posts_posts_path, notice: 'Post was successfully published.'
    else
      redirect_to @post, notice: 'Not an authorized user' 
    end
  end

  def unpublished
    if @post.users_post(current_user)
      @post.unpublish!
      redirect_to blog_posts_posts_path, notice: 'Post was successfully unpublished.'
    else
      redirect_to @post, notice: 'Not an authorized user' 
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published_at)
    end
end
