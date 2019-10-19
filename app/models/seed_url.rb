class SeedUrl < ApplicationRecord
  belongs_to :web_link
end

# == Schema Information
#
# Table name: seed_urls
#
#  id              :integer          not null, primary key
#  web_link_id     :integer          not null
#  last_scraped_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
