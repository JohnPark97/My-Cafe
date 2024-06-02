class CreateCafes < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:cafes)
      create_table :cafes do |t|
        t.string :name
        t.string :subdomain, null: false

        t.timestamps
      end
    end

    %w[cafe_one cafe_two].each do |schema|
      within_schema(schema) do
        unless table_exists?(:cafes)
          create_table :cafes do |t|
            t.string :name
            t.string :subdomain, null: false

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
