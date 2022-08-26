class CreateWpcolumns < ActiveRecord::Migration[6.0]
  def change
    create_table :wpcolumns do |t|
      t.integer :article_id
      t.text :text_en
      t.text :text_nl
      t.integer :orderid
	t.timestamps
    end
  end
end
