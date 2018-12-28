class Word < ApplicationRecord
  validates :text, uniqueness: true
  has_one :my_word, dependent: :destroy

  scope :with_text, ->(text){
    where(text: text)
  }
end
