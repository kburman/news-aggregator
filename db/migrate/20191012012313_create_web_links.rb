class CreateWebLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :web_links do |t|
      t.references :web_domain, null: false, foreign_key: true
      t.string :path, null: false
      t.text :scheme, null: false
      t.integer :port, null: false

      t.timestamps
    end
  end
end
