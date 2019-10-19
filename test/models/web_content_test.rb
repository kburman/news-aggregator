require 'test_helper'

class WebContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
# Schema version: 20191019162534
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
# Indexes
#
#  index_web_contents_on_web_link_id  (web_link_id)
#
