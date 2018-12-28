class MyWord < ApplicationRecord
  belongs_to :word
  delegate :text, to: :word

  scope :with_word, ->(word){
    where(word: word)
  }
end
