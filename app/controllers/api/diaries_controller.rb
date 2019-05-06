class Api::DiariesController < ApplicationController
  before_action :verify_post_user
  before_action :find_diary, only: [:prev, :next]

  def create
    diary = Diary.new(diary_params)
    render json: {success: diary.save, msg: diary.errors.full_messages}
  end

  def prev
    prev_diary = Diary.prev(@diary)
    render json: {
      diary: prev_diary&.json_attributes,
      is_latest: prev_diary&.prev.blank?
    }
  end

  def next
    next_diary = Diary.next(@diary)
    render json: {
      diary: next_diary&.json_attributes,
      is_latest: next_diary&.next.blank?
    }
  end

  private

  def find_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params[:diary].permit(:content)
  end
end
