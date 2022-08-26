class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :block_en
      t.string :block_nl
      t.string :cite_nl
      t.string :cite_en
      t.integer :article_id
    end
  end
end
