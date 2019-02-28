class HomeController < ApplicationController
  def index
    @posts = Post.page(1).per(20)
                 .order("updated_at desc")
                 .select(:id, :title, :updated_at)
                 .map(&:json_attributes)
  end
end
