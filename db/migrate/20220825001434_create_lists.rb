class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.integer :article_id
      t.integer :orderid
	t.timestamps
    end
    create_table :listitems do |t|
      t.integer :list_id
      t.string :text_en
      t.string :text_nl
	t.timestamps
    end
  end
end
