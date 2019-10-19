require 'test_helper'

class SeedUrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
# Schema version: 20191019162534
#
# Table name: seed_urls
#
#  id              :integer          not null, primary key
#  web_link_id     :integer          not null
#  last_scraped_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_seed_urls_on_web_link_id  (web_link_id) UNIQUE
#
