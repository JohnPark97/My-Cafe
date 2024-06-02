class CreateMenuItems < ActiveRecord::Migration[7.1]
  def change
    %w[cafe_one cafe_two].each do |schema|
      within_schema(schema) do
        unless table_exists?(:menu_items)
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
    end
  end

  private

  def within_schema(schema)
    original_schema = ActiveRecord::Base.connection.schema_search_path
    ActiveRecord::Base.connection.schema_search_path = schema
    yield
  ensure
    ActiveRecord::Base.connection.schema_search_path = original_schema
  end
end
