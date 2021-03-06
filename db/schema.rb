# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_08_130043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backerinvoices", force: :cascade do |t|
    t.string "amount"
    t.string "captureid"
    t.bigint "backer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backer_id"], name: "index_backerinvoices_on_backer_id"
  end

  create_table "backers", force: :cascade do |t|
    t.string "pledgeamountperperson"
    t.string "eachmilestoneamount"
    t.boolean "paymentstatus", default: false
    t.string "paymentid"
    t.string "payerid"
    t.string "token"
    t.string "authorization"
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_backers_on_campaign_id"
    t.index ["user_id"], name: "index_backers_on_user_id"
  end

  create_table "badges", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_badges_on_user_id"
  end

  create_table "campaignreviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaignreviews_on_campaign_id"
    t.index ["user_id"], name: "index_campaignreviews_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.text "blurb"
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "location"
    t.integer "pledge_amount"
    t.integer "no_of_participants"
    t.date "pledge_deadline"
    t.integer "status", default: 0
    t.boolean "featuredstatus", default: false
    t.string "askfromcommunity"
    t.integer "projectchampionstatus", default: 0
    t.integer "projectchampionminimumamount"
    t.text "projectchampiontext"
    t.string "projectchampionvideo_file_name"
    t.string "projectchampionvideo_content_type"
    t.integer "projectchampionvideo_file_size"
    t.datetime "projectchampionvideo_updated_at"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.boolean "allowmilestone", default: false
    t.index ["category_id"], name: "index_campaigns_on_category_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_faqs_on_campaign_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "owner_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_images_on_owner_type_and_owner_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_invites_on_campaign_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "duration_type"
    t.integer "duration_limit"
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.integer "status", default: 0
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_milestones_on_campaign_id"
  end

  create_table "milestoneupdates", force: :cascade do |t|
    t.bigint "milestone_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["milestone_id"], name: "index_milestoneupdates_on_milestone_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "projectchampions", force: :cascade do |t|
    t.integer "projectchampiontotalamount"
    t.integer "projectchampionpaidamount"
    t.boolean "paymentstatus", default: false
    t.bigint "campaign_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_projectchampions_on_campaign_id"
    t.index ["user_id"], name: "index_projectchampions_on_user_id"
  end

  create_table "riskandchallenges", force: :cascade do |t|
    t.text "description"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_riskandchallenges_on_campaign_id"
  end

  create_table "userbadges", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_userbadges_on_badge_id"
    t.index ["user_id"], name: "index_userbadges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "referalcode", default: ""
    t.string "referby", default: ""
    t.text "biography", default: ""
    t.text "websites", default: ""
    t.text "contact", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "backerinvoices", "backers"
  add_foreign_key "backers", "campaigns"
  add_foreign_key "backers", "users"
  add_foreign_key "badges", "users"
  add_foreign_key "campaignreviews", "campaigns"
  add_foreign_key "campaignreviews", "users"
  add_foreign_key "campaigns", "categories"
  add_foreign_key "campaigns", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "faqs", "campaigns"
  add_foreign_key "invites", "campaigns"
  add_foreign_key "invites", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "milestones", "campaigns"
  add_foreign_key "milestoneupdates", "milestones"
  add_foreign_key "posts", "users"
  add_foreign_key "projectchampions", "campaigns"
  add_foreign_key "projectchampions", "users"
  add_foreign_key "riskandchallenges", "campaigns"
  add_foreign_key "userbadges", "badges"
  add_foreign_key "userbadges", "users"
end
