class CreateMusicians < ActiveRecord::Migration[6.0]
  def change
    create_table :musicians do |t|
      t.integer :article_id
      t.string :title
      t.string :subtitle_en
      t.string :subtitle_nl
      t.string :image
      t.string :link
      t.timestamps
    end
  end
end
