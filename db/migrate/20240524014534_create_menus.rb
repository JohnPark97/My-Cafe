class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :availability
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
