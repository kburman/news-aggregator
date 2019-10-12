class CreateScrapeServices < ActiveRecord::Migration[6.0]
  def change
    create_table :scrape_services do |t|
      t.references :web_domain, null: false, foreign_key: true
      t.text :scraper_klass_fq_name, null: false

      t.timestamps
    end
  end
end
