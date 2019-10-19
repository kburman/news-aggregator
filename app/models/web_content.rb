class WebContent < ApplicationRecord
  belongs_to :web_link
end

# == Schema Information
#
# Table name: web_contents
#
#  id               :integer          not null, primary key
#  web_link_id      :integer          not null
#  response_headers :text
#  response_body    :binary
#  body_size        :integer
#  content_type     :text
#  scraped_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
