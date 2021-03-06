class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  # before_action :guest_log_in, only: %i[ new edit create update destroy]

  # GET /blogs or /blogs.json
  def index
    @tag_list = Tag.all
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @blog_tags = @blog.tags
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    # @blog.images.build
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    tag_list = params[:blog][:tag_name].split(nil)

    respond_to do |format|
      if @blog.save
        @blog.save_tag(tag_list)
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    tag_list = params[:blog][:tag_name].split(nil)

    respond_to do |format|
      if @blog.update(blog_params)
        @blog.save_tag(tag_list)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @blogs = @tag.blogs.all
  end

  def coach_lp; end

  def myself_lp; end

  private

    # def guest_log_in
    #   redirect_to root_path if current_user.email == 'guest@example.com'
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content, :avatar)
    end
end
