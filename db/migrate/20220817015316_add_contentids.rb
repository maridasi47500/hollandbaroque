class AddContentids < ActiveRecord::Migration[6.0]
  def change
add_column :contents, :orderid,:integer
add_column :mediatexts, :orderid,:integer
add_column :youtubes, :orderid,:integer
add_column :swipers, :orderid,:integer
add_column :galleries, :orderid,:integer
add_column :tickers, :orderid,:integer
add_column :musicians, :orderid,:integer
  end
end
