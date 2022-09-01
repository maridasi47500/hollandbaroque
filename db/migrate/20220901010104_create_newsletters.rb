class CreateNewsletters < ActiveRecord::Migration[6.0]
  def change
    create_table :newsletters do |t|
      t.string :firstname
      t.string :prefix
      t.string :lastname
      t.string :email
      t.boolean :newsletter
      t.boolean :brochures
      t.string :street
      t.string :housenumber
      t.string :postcode
      t.string :city
      t.string :country
      t.string :phone
      t.boolean :privacy
      t.timestamps
    end
  end
end
