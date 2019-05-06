class Diary < ApplicationRecord
  class << self
    def prev current_diary
      where("id < ?", current_diary.id).last
    end

    def next current_diary
      where("id > ?", current_diary.id).first
    end
  end

  def prev
    Diary.prev(self)
  end

  def next
    Diary.next(self)
  end

  def json_attributes
    {
      id: id,
      content: content.gsub(/\n/, '</br>'),
      created_at: created_at.strftime("%m月%d日")
    }
  end
end
