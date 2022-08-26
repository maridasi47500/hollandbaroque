class CreateRelatedposts < ActiveRecord::Migration[6.0]
  def change
    create_table :relatedposts do |t|
      t.integer :article_id
      t.integer :otherarticle_id
    end
  end
end
