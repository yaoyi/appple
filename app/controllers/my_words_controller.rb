class MyWordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  def destroy
    my_word = MyWord.find(params[:id])
    my_word.destroy
    @my_words = MyWord.all
    respond_to do |wants|
      wants.js {}
      wants.json {
        render json: @my_words.map{|w| {id: w.id, text: w.text}}
      }
    end
  end
end
