class ScrapeService < ApplicationRecord
  belongs_to :web_domain

  validates_presence_of :scraper_klass_fq_name
  validates_uniqueness_of :scraper_klass_fq_name, scope: :web_domain_id

  def scraper_klass
    scraper_klass_fq_name.constantize
  end
end

# == Schema Information
# Schema version: 20191019162534
#
# Table name: scrape_services
#
#  id                    :integer          not null, primary key
#  web_domain_id         :integer          not null
#  scraper_klass_fq_name :text             not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_scrape_services_on_web_domain_id  (web_domain_id)
#
