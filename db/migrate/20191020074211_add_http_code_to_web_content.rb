class AddHttpCodeToWebContent < ActiveRecord::Migration[6.0]
  def change
    add_column :web_contents, :http_code, :integer, null: false
  end
end
