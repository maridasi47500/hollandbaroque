class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.string :typefriendship
      t.boolean :authorize
      t.string :amount
      t.string :iban
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :street
      t.string :housenumber
      t.string :postcode
      t.string :place
      t.string :land
      t.string :email
      t.string :telephone
      t.boolean :newsletter
      t.timestamps
    end
  end
end
