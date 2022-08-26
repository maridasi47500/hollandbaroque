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

ActiveRecord::Schema.define(version: 2022_08_25_001434) do

  create_table "articles", force: :cascade do |t|
    t.string "title_en"
    t.string "title_nl"
    t.string "type"
    t.string "date_en"
    t.string "date_nl"
    t.string "subtitle_en"
    t.string "subtitle_nl"
    t.text "intro_en"
    t.text "intro_nl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "url_en"
    t.string "url_nl"
  end

  create_table "contents", force: :cascade do |t|
    t.string "type"
    t.text "text_en"
    t.text "text_nl"
    t.integer "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orderid"
  end

  create_table "galleries", force: :cascade do |t|
    t.integer "article_id"
    t.string "name_en"
    t.string "name_nl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orderid"
  end

  create_table "galleryimages", force: :cascade do |t|
    t.integer "gallery_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer "width"
    t.integer "height"
    t.string "source"
    t.integer "article_id"
    t.integer "orderid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listitems", force: :cascade do |t|
    t.integer "list_id"
    t.string "text_en"
    t.string "text_nl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer "article_id"
    t.integer "orderid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mediatexts", force: :cascade do |t|
    t.string "content_nl"
    t.string "content_en"
    t.string "type"
    t.string "url_nl"
    t.string "url_en"
    t.string "title_en"
    t.string "title_nl"
    t.integer "article_id"
    t.integer "orderid"
  end

  create_table "musicians", force: :cascade do |t|
    t.integer "article_id"
    t.string "title"
    t.string "subtitle_en"
    t.string "subtitle_nl"
    t.string "image"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orderid"
  end

  create_table "myfiles", force: :cascade do |t|
    t.integer "orderid"
    t.integer "article_id"
    t.string "url"
    t.string "mytype"
    t.string "label"
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "object_table_concerts", force: :cascade do |t|
    t.integer "orderid"
    t.integer "concert_id"
  end

  create_table "playdateswrappers", force: :cascade do |t|
    t.integer "article_id"
    t.integer "orderid"
  end

  create_table "playtimes", force: :cascade do |t|
    t.integer "concert_id"
    t.time "time"
    t.date "date"
    t.integer "location_id"
    t.string "namelink_en"
    t.string "namelink_nl"
    t.string "link_en"
    t.string "link_nl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "article_id"
    t.integer "orderid"
    t.integer "productid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "block_en"
    t.string "block_nl"
    t.string "cite_nl"
    t.string "cite_en"
    t.integer "article_id"
  end

  create_table "relatedposts", force: :cascade do |t|
    t.integer "article_id"
    t.integer "otherarticle_id"
  end

  create_table "sitepages", force: :cascade do |t|
    t.string "title_en"
    t.string "title_nl"
    t.text "subtitle_en"
    t.text "subtitle_nl"
    t.string "url_en"
    t.string "url_nl"
  end

  create_table "swiperimages", force: :cascade do |t|
    t.integer "swiper_id"
    t.string "name"
    t.string "title_nl"
    t.string "title_en"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "width"
    t.string "height"
  end

  create_table "swipers", force: :cascade do |t|
    t.integer "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orderid"
  end

  create_table "tickers", force: :cascade do |t|
    t.string "text_en"
    t.string "text_nl"
    t.text "subscript_en"
    t.text "subscript_nl"
    t.integer "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "orderid"
  end

  create_table "videoshavetypes", force: :cascade do |t|
    t.integer "postkl_id"
    t.integer "videotype_id"
  end

  create_table "videotypes", force: :cascade do |t|
    t.string "name_en"
    t.string "name_nl"
    t.string "url_en"
    t.string "url_nl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wpcolumns", force: :cascade do |t|
    t.integer "article_id"
    t.text "text_en"
    t.text "text_nl"
    t.integer "orderid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "youtubes", force: :cascade do |t|
    t.string "url"
    t.integer "article_id"
    t.string "title_en"
    t.string "title_nl"
    t.integer "orderid"
  end

end
