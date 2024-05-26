class AddDefaultAdminUser < ActiveRecord::Migration[6.0]
  def up
    User.create!(
      email: 'admin@example.com',
      password: ENV['ADMIN_PASSWORD'],  # Securely set in environment variables
      password_confirmation: ENV['ADMIN_PASSWORD'],  # Ensure password matches
      admin: true
    )
  end

  def down
    User.find_by(email: 'admin@example.com')&.destroy
  end
end
