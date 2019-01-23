class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :listing, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :guest_number
      t.date :checkin_date
      t.date :checkout_date
      t.string :request
      t.timestamps
    end
  end
end
