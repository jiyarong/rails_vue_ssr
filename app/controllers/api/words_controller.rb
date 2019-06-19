class Api::WordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_post_user, only: [:update]

  def index
    params[:status] ||= nil
    @words = Word.page(params[:page] || 1).per(20)
    if params[:status].present?
      @words = @words.where(status: params[:status])
    end

    render json: {
      last_page: @words.last_page? || @words.blank?,
      words: @words
    }
  end

  def create
    Word.create(word_params)
    response.set_header("Access-Control-Allow-Origin", "*")
    render json: {msg: "ok"}
  end

  def update
    @word = Word.find(params[:id])
    @word.update_column(:status, params[:status])
    render json: {msg: "ok"}
  end

  private

  def word_params
    params.require(:word).permit(:text, :result, :link, dict: [])
  end
end
