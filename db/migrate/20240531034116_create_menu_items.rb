class CreateMenuItems < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false
      t.boolean :availability, default: true
      t.string :image_url
      t.references :category, foreign_key: true, null: false
      t.references :cafe, foreign_key: true, null: false

      t.timestamps
    end
  end
end
