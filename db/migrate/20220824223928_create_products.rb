class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :article_id
      t.integer :orderid
      t.integer :productid
      t.timestamps
    end
  end
end
