class WebArticle < ApplicationRecord
  belongs_to :web_link
end

# == Schema Information
# Schema version: 20191019162534
#
# Table name: web_articles
#
#  id          :integer          not null, primary key
#  title       :text
#  body        :text
#  web_link_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_web_articles_on_web_link_id  (web_link_id)
#
