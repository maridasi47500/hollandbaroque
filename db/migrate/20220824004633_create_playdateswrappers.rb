class CreatePlaydateswrappers < ActiveRecord::Migration[6.0]
  def change
    create_table :playdateswrappers do |t|
      t.integer :article_id
      t.integer :orderid
    end
  end
end
