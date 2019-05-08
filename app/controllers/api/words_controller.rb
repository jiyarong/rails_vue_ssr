class Api::WordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Word.create(word_params)
    response.set_header("Access-Control-Allow-Origin", "*")
    render json: {msg: "ok"}
  end

  private

  def word_params
    params.require(:word).permit(:text, :result, :link, dict: [])
  end
end
