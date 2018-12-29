class MyWordsController < ApplicationController
  def destroy
    my_word = MyWord.find(params[:id])
    my_word.destroy
    @my_words = MyWord.all
  end
end
