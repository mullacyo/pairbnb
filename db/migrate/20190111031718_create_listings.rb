class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
    	t.string :name, null: false
    	t.string :description, null: false
    	t.string :place_type, null: false
    	t.string :property_type, null: false
    	t.integer :room_number, null: false
    	t.integer :bed_number, null: false
    	t.integer :guest_number, null: false
    	t.string :address, null: false
    	t.string :city, null: false
    	t.string :state, null: false
    	t.string :country, null: false
    	t.integer :zipcode, null: false
    	t.float :price, null: false
    	t.references :user, foreign_key: true
     	t.timestamps
    end
  end
end
