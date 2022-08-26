class AddWidthToSwiperimages < ActiveRecord::Migration[6.0]
  def change
    add_column :swiperimages, :width, :string
    add_column :swiperimages, :height, :string
  end
end
