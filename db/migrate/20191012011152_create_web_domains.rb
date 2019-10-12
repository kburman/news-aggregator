class CreateWebDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :web_domains do |t|
      t.text :domain_name, null: false, unique: true
      t.integer :domain_status, null: false, default: 0

      t.timestamps
    end
    add_index :web_domains, :domain_name, unique: true
  end
end
