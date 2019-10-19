class WebDomain < ApplicationRecord
  enum domain_status: [:active, :inactive]

  has_many :web_links
  has_one :scrape_service
end

# == Schema Information
# Schema version: 20191019162534
#
# Table name: web_domains
#
#  id            :integer          not null, primary key
#  domain_name   :text             not null
#  domain_status :integer          default("0"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_web_domains_on_domain_name  (domain_name) UNIQUE
#
