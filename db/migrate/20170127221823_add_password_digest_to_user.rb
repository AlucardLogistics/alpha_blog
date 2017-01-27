class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    #adding a new column to users table password_digest for the use of the bcrypt gem
    add_column :users, :password_digest, :string
  end
end
