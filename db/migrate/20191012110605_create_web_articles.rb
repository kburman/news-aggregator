class CreateWebArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :web_articles do |t|
      t.text :title
      t.text :body
      t.references :web_link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
