class Post < ApplicationRecord
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags, allow_destroy: true

  scope :list, -> (page: 1, per: 20) {
    page(page).per(per).order("updated_at desc").select(:id, :title, :updated_at).includes(:tags)
  }

  def json_attributes
    attributes.merge(updated_at: human_updated_at, tags: tags)
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
