class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:save]

  def index
    @my_words = MyWord.all
  end

  def react

  end

  def search
    query = params[:query].strip
    ret = $blurrily.find(query, 1024)
    ids = ret.map{|x| x[0]}
    my_word_ids = MyWord.with_word(ids).pluck(:word_id)
    ids = (ids - my_word_ids).take(10)
    words = Word.find(ids)
    words = words.map{|w| {value: w.text, data: w.id}}
    render json: {suggestions: words}
  end

  def save
    word = Word.find(params[:id])
    word.create_my_word if !word.my_word
    @my_words = MyWord.all
    respond_to do |wants|
      wants.js {}
      wants.json {
        render json: @my_words.map{|w| {id: w.id, text: w.text}}
      }
    end
  end

  def my_words
    my_words = MyWord.all
    render json: my_words.map{|w| {id: w.id, text: w.text}}
  end
end
