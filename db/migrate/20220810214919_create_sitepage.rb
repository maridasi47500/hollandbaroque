class CreateSitepage < ActiveRecord::Migration[6.0]
  def change
    create_table :sitepages do |t|
      t.string :title_en
      t.string :title_nl
      t.text :subtitle_en
      t.text :subtitle_nl
      t.string :url_en
      t.string :url_nl
    end
  end
end
