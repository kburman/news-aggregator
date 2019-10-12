# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_12_110605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scrape_services", force: :cascade do |t|
    t.bigint "web_domain_id", null: false
    t.text "scraper_klass_fq_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["web_domain_id"], name: "index_scrape_services_on_web_domain_id"
  end

  create_table "web_articles", force: :cascade do |t|
    t.text "title"
    t.text "body"
    t.bigint "web_link_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["web_link_id"], name: "index_web_articles_on_web_link_id"
  end

  create_table "web_domains", force: :cascade do |t|
    t.text "domain_name", null: false
    t.integer "domain_status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["domain_name"], name: "index_web_domains_on_domain_name", unique: true
  end

  create_table "web_links", force: :cascade do |t|
    t.bigint "web_domain_id", null: false
    t.string "path", null: false
    t.text "scheme", null: false
    t.integer "port", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["web_domain_id", "path"], name: "index_web_links_on_web_domain_id_and_path", unique: true
    t.index ["web_domain_id"], name: "index_web_links_on_web_domain_id"
  end

  add_foreign_key "scrape_services", "web_domains"
  add_foreign_key "web_articles", "web_links"
  add_foreign_key "web_links", "web_domains"
end
