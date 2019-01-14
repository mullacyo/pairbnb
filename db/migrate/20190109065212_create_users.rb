class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :gender, null: false
      t.string :phone, null: false
      t.string :country, null: false
      t.date :birthdate, null: false
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
      t.timestamps null: false
    end
    add_index :users, :email
    add_index :users, :remember_token
  end
end
