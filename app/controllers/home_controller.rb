class HomeController < ApplicationController
  def index
    puts request.path
    puts "----"
    @posts = Post.list.map(&:json_attributes)
    if id = request.path.gsub(/\/posts\//, '')
      if post = Post.find_by(id: id)
        @post = {
          id: id,
          title: post.title,
          content: post.content,
          tags: post.tags.select(:name, :id)
        }
      end
    end
  end
end
