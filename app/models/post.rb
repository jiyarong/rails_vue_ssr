class Post < ApplicationRecord
  # has_many :post_tags, class_name: 'PostTags', inverse_of: :post
  # has_many :tags, through: :post_tags
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags, allow_destroy: true

  def json_attributes
    attributes.merge(updated_at: human_updated_at, tags: tags.select(:name, :id))
  end

  def human_updated_at
    time_now = Time.now
    hours = (time_now - updated_at) / 3600
    if hours <= 1
      "#{((time_now - updated_at) / 60).to_i}分钟前"
    elsif hours < 24
      "#{((time_now - updated_at) / 3600).to_i}小时前"
    elsif hours < 24 * 30
      "#{((time_now - updated_at) / 3600 / 24).to_i}天前"
    elsif hours < 24 * 90
      "#{((time_now - updated_at) / 3600 / 24 / 30).to_i}个月前"
    else
      updated_at.strftime("%m-%d")
    end
  end
end
