class CreateSchemas < ActiveRecord::Migration[7.1]
  def change
    execute "CREATE SCHEMA IF NOT EXISTS cafe_one"
    execute "CREATE SCHEMA IF NOT EXISTS cafe_two"
  end
end
