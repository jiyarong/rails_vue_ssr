class Diary < ApplicationRecord
  def json_attributes
    {
      content: content.gsub(/\n/, '</br>'),
      created_at: created_at.strftime("%m月%d日")
    }
  end
end
