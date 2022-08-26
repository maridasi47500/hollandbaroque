class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.integer :width
      t.integer :height
      t.string :source
      t.integer :article_id
      t.integer :orderid
	t.timestamps
    end
  end
end
