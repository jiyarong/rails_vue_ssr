class Api::DiariesController < ApplicationController
  before_action :verify_post_user

  def create
    diary = Diary.new(diary_params)
    render json: {success: diary.save, msg: diary.errors.full_messages}
  end

  private

  def diary_params
    params[:diary].permit(:content)
  end
end
