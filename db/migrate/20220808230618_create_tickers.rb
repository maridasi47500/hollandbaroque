class CreateTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :tickers do |t|
      t.string :text_en
      t.string :text_nl
      t.text :subscript_en
      t.text :subscript_nl
      t.integer :article_id
      t.timestamps
    end
  end
end
