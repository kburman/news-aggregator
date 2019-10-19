class WebLink < ApplicationRecord
  belongs_to :web_domain
  has_one :web_article

  validates :path, uniqueness: { scope: :web_domain_id }
  validates :scheme,   inclusion: %w(http https)
  validates :port, numericality: { only_integer: true }, allow_nil: false
  validates_length_of :port, minimum: 2**0, maximum: 2**16

  def full_link
    URI.join("#{scheme}://#{web_domain.domain_name}:#{port}", path)
  end
end

# == Schema Information
# Schema version: 20191019162534
#
# Table name: web_links
#
#  id            :integer          not null, primary key
#  web_domain_id :integer          not null
#  path          :string           not null
#  scheme        :text             not null
#  port          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_web_links_on_web_domain_id           (web_domain_id)
#  index_web_links_on_web_domain_id_and_path  (web_domain_id,path) UNIQUE
#
