class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    %w[cafe_one cafe_two].each do |schema|
      within_schema(schema) do
        unless table_exists?(:categories)
          create_table :categories do |t|
            t.string :name, null: false
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
