class CreateVideoshavetypes < ActiveRecord::Migration[6.0]
  def change
    create_table :videoshavetypes do |t|
      t.integer :postkl_id
      t.integer :videotype_id
    end
  end
end
