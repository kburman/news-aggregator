class AddIndexToWebLink < ActiveRecord::Migration[6.0]
  def change
    add_index :web_links, [:web_domain_id, :path], unique: true
  end
end
