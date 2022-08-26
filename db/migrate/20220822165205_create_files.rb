class CreateFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :myfiles do |t|
      t.integer :orderid
      t.integer :article_id
      t.string :url
      t.string :mytype
      t.string :label
      t.string :filename
	t.timestamps
    end
  end
end
