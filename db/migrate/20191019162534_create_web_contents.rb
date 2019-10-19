class CreateWebContents < ActiveRecord::Migration[6.0]
  def change
    create_table :web_contents do |t|
      t.references :web_link, null: false, foreign_key: true
      t.text :response_headers
      t.binary :response_body
      t.bigint :body_size
      t.text :content_type
      t.datetime :scraped_at

      t.timestamps
    end
  end
end
