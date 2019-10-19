class CreateSeedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :seed_urls do |t|
      t.references :web_link, null: false, foreign_key: true, index: { unique: true }
      t.datetime :last_scraped_at

      t.timestamps
    end
  end
end
