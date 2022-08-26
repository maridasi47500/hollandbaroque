class CreateConcerts < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title_en
      t.string :title_nl
      t.string :type
      t.string :date_en
      t.string :date_nl
      t.string :subtitle_en
      t.string :subtitle_nl
      t.text :intro_en
      t.text :intro_nl
	t.timestamps
    end
    create_table :contents do |t|
      t.string :type
      t.text :text_en
      t.text :text_nl
      t.integer :article_id

	t.timestamps
    end
    create_table :playtimes do |t|
      t.integer :concert_id
      t.time :time
      t.date :date

      t.integer :location_id
      t.string :namelink_en
      t.string :namelink_nl
      t.string :link_en
      t.string :link_nl
	t.timestamps
    end
    create_table :locations do |t|
      t.string :city
      t.string :place
	t.timestamps
	end
  end
end
