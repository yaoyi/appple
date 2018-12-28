class CreateMyWords < ActiveRecord::Migration[5.1]
  def change
    create_table :my_words do |t|
      t.references :word
      t.timestamps
    end
  end
end
