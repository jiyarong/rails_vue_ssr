class Api::PostsController < ApplicationController
  before_action :get_post, only: [:show, :update, :destroy]
  before_action :verify_post_user, except: [:index, :show]

  def index
    @posts = Post.list(page: params[:page] || 1, per: params[:per] || 20)
    render json: {
        last_page: @posts.last_page? || @posts.blank?,
        posts: @posts.map(&:json_attributes)
    }
  end

  def show
    render json: {title: @post.title, content: @post.content, tags: @post.tags.select(:name, :id)}
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
    params[:post].permit(:title, :content, tag_ids: [], tags_attributes: [:name])
  end
end
