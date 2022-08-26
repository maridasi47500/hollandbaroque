class CreateVideotypes < ActiveRecord::Migration[6.0]
  def change
    create_table :videotypes do |t|
      t.string :name_en
      t.string :name_nl
      t.string :url_en
      t.string :url_nl
      t.timestamps
    end
  end
end
