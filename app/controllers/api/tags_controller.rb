class Api::TagsController < ApplicationController
  def index
    @tags = Tag.all.select(:id, :name).map(&:attributes)
    render json: {tags: @tags}
  end
end
