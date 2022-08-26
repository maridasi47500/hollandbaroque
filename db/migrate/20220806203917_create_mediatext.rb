class CreateMediatext < ActiveRecord::Migration[6.0]
  def change
    create_table :mediatexts do |t|
      t.string :content_nl
      t.string :content_en
      t.string :type
      t.string :url_nl
      t.string :url_en
      t.string :title_en
      t.string :title_nl
      t.integer :article_id
    end
  end
end
