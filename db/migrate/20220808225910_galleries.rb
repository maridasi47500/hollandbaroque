class Galleries < ActiveRecord::Migration[6.0]
  def change
create_table :galleries do |t|
t.integer :article_id
t.string :name_en
t.string :name_nl
t.timestamps
end
create_table :galleryimages do |t|
t.integer :gallery_id
t.string :name
t.timestamps
end
  end
end
