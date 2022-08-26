class CreateObjectTableConcerts < ActiveRecord::Migration[6.0]
  def change
    create_table :object_table_concerts do |t|
      t.integer :orderid
      t.integer :concert_id
    end
  end
end
