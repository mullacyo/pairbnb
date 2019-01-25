class ChangeUsersColumnNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :gender, true
    change_column_null :users, :phone, true
    change_column_null :users, :country, true
    change_column_null :users, :birthdate, true
    change_column_null :users, :gender, true
    change_column_null :users, :gender, true
  end
end
