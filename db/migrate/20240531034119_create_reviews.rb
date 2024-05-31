class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true, null: false
      t.references :cafe, foreign_key: true, null: false
      t.references :menu_item, foreign_key: true
      t.text :content, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
