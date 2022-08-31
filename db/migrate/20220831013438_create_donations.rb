class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.string :amount
      t.string :namely
      t.string :firstname
      t.string :email
      t.string :middlename
      t.string :lastname
      t.string :brochures
      t.string :street
      t.string :housenumber
      t.string :postcode
      t.string :place
      t.string :privacy
      t.string :telephone
      t.timestamps
    end
  end
end
