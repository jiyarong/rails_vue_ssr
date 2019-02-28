class Api::PostsController < ApplicationController
  before_action :get_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.page(params[:page] || 1).per(params[:per_page] || 20)
                 .order("updated_at desc")
                 .select(:id, :title, :updated_at)
    render json: {
        last_page: @posts.last_page? || @posts.blank?,
        posts: @posts.map(&:json_attributes)
    }
  end

  def show
    render json: {title: @post.title, content: @post.content}
  end

  def create
    @post = Post.new(post_params)
    render json: {success: @post.save, msg: @post.errors.full_messages}
  end

  def update
    render json: {success: @post.update(post_params), msg: @post.errors.full_messages}
  end

  def destroy

  end

  private
  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post].permit(:title, :content)
  end
end
