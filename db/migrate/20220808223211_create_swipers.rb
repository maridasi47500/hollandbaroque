class CreateSwipers < ActiveRecord::Migration[6.0]
  def change
    create_table :swipers do |t|
      t.integer :article_id
      t.timestamps
    end
    create_table :swiperimages do |t|
      t.integer :swiper_id
      t.string :name
      t.string :title_nl
      t.string :title_en
      t.timestamps
    end
  end
end
