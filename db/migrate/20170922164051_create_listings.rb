class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
	  t.string :description
	  t.string :property_type

	  t.integer :room_number
	  t.integer :bed_number
	  t.integer :guest_number
	  t.string :address
	  t.string :state
	  t.integer :postcode

	  t.decimal :price

	  t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
