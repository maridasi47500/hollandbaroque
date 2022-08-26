class AddUrlToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :url_en, :string
    add_column :articles, :url_nl, :string
  end
end
