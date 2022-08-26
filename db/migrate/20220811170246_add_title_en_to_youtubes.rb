class AddTitleEnToYoutubes < ActiveRecord::Migration[6.0]
  def change
    add_column :youtubes, :title_en, :string
    add_column :youtubes, :title_nl, :string
  end
end
