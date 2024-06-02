class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    %w[cafe_one cafe_two].each do |schema|
      within_schema(schema) do
        unless table_exists?(:users)
          create_table :users do |t|
            t.string :email, null: false, default: ""
            t.string :encrypted_password, null: false, default: ""
            t.boolean :admin, default: false
            t.references :cafe, foreign_key: true, null: false

            t.timestamps null: false
          end

          add_index :users, :email, unique: true
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
