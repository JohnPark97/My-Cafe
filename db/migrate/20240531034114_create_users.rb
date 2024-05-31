# db/migrate/YYYYMMDDHHMMSS_create_users.rb
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
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
