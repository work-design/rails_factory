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

ActiveRecord::Schema.define(version: 2018_05_16_141623) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "area_id"
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_addresses_on_area_id"
    t.index ["buyer_id"], name: "index_addresses_on_buyer_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nation", default: ""
    t.string "province", default: ""
    t.string "city", default: ""
    t.string "district", default: ""
    t.boolean "published", default: true
    t.boolean "popular", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_item_serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cart_item_id"
    t.bigint "serve_id"
    t.string "scope"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_serves_on_cart_item_id"
    t.index ["serve_id"], name: "index_cart_item_serves_on_serve_id"
  end

  create_table "cart_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.string "good_type"
    t.bigint "good_id"
    t.string "session_id", limit: 128
    t.string "status"
    t.integer "quantity"
    t.string "extra", limit: 1024
    t.boolean "checked", default: false
    t.boolean "myself"
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_cart_items_on_buyer_id"
    t.index ["good_type", "good_id"], name: "index_cart_items_on_good_type_and_good_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.decimal "quantity", precision: 10
    t.string "unit"
    t.decimal "price", precision: 10
    t.integer "sales_count"
    t.boolean "published", default: true
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promote_id"], name: "index_goods_on_promote_id"
    t.index ["sku"], name: "index_goods_on_sku"
  end

  create_table "govern_taxons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "position", default: 0
    t.integer "governs_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "governs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "position", default: 0
    t.integer "govern_taxon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["govern_taxon_id"], name: "index_governs_on_govern_taxon_id"
  end

  create_table "log_mailers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message_object_id"
    t.string "mailer"
    t.string "action"
    t.string "params"
    t.string "mail_to"
    t.string "cc_to"
    t.string "sent_status"
    t.string "sent_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_records", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "path"
    t.string "controller"
    t.string "action"
    t.string "params", limit: 2048
    t.string "headers", limit: 4096
    t.string "cookie", limit: 2048
    t.string "session", limit: 2048
    t.string "exception", limit: 10240
    t.string "exception_object"
    t.text "exception_backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.string "notifiable_types"
    t.integer "showtime"
    t.boolean "accept_email", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_type", "receiver_id"], name: "index_notification_settings_on_receiver_type_and_receiver_id"
  end

  create_table "notifications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.string "code"
    t.integer "state", default: 0
    t.string "title"
    t.string "body", limit: 5000
    t.string "link"
    t.datetime "sending_at"
    t.datetime "sent_at"
    t.string "sent_result"
    t.datetime "read_at"
    t.boolean "verbose", default: false
    t.string "cc_emails"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["receiver_type", "receiver_id"], name: "index_notifications_on_receiver_type_and_receiver_id"
  end

  create_table "notify_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "notifiable_type"
    t.string "code"
    t.string "notify_mailer"
    t.string "notify_method"
    t.string "only_verbose_columns"
    t.string "except_verbose_columns"
    t.string "cc_emails"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "type"
    t.string "uid"
    t.string "name"
    t.string "avatar_url"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauth_users_on_user_id"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "cart_item_id"
    t.string "good_type"
    t.bigint "good_id"
    t.integer "quantity"
    t.integer "number"
    t.decimal "pure_price", precision: 10, scale: 2
    t.decimal "promote_sum", precision: 10, scale: 2
    t.decimal "serve_sum", precision: 10, scale: 2
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_order_items_on_cart_item_id"
    t.index ["good_type", "good_id"], name: "index_order_items_on_good_type_and_good_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_promotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "order_item_id"
    t.bigint "promote_id"
    t.bigint "promote_charge_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_promotes_on_order_id"
    t.index ["order_item_id"], name: "index_order_promotes_on_order_item_id"
    t.index ["promote_charge_id"], name: "index_order_promotes_on_promote_charge_id"
    t.index ["promote_id"], name: "index_order_promotes_on_promote_id"
  end

  create_table "order_serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "order_item_id"
    t.bigint "serve_id"
    t.bigint "serve_charge_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_serves_on_order_id"
    t.index ["order_item_id"], name: "index_order_serves_on_order_item_id"
    t.index ["serve_charge_id"], name: "index_order_serves_on_serve_charge_id"
    t.index ["serve_id"], name: "index_order_serves_on_serve_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.bigint "payment_strategy_id"
    t.string "uuid", null: false
    t.integer "state", default: 0
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "received_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "subtotal", precision: 10, scale: 2
    t.decimal "pure_serve_sum", precision: 10, scale: 2
    t.decimal "pure_promote_sum", precision: 10, scale: 2
    t.decimal "serve_sum", precision: 10, scale: 2
    t.decimal "promote_sum", precision: 10, scale: 2
    t.string "currency"
    t.integer "payment_id"
    t.string "payment_type"
    t.integer "payment_status"
    t.boolean "myself"
    t.string "note", limit: 4096
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["payment_strategy_id"], name: "index_orders_on_payment_strategy_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "part_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "part_id"
    t.string "qr_code"
    t.string "state"
    t.datetime "received_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_item_id"
    t.index ["part_id"], name: "index_part_items_on_part_id"
    t.index ["product_item_id"], name: "index_part_items_on_product_item_id"
  end

  create_table "part_plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "part_id"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "state"
    t.integer "purchased_count", default: 0
    t.integer "received_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_part_plans_on_part_id"
  end

  create_table "parts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "provider_id"
    t.string "name"
    t.string "qr_prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_parts_on_provider_id"
  end

  create_table "payment_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "account_name"
    t.string "account_num"
    t.string "bank"
    t.text "extra"
    t.boolean "verified"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_payment_methods_on_creator_id"
  end

  create_table "payment_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "payment_id"
    t.bigint "order_id"
    t.decimal "order_amount", precision: 10, scale: 2
    t.decimal "check_amount", precision: 10, scale: 2
    t.integer "state", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payment_orders_on_order_id"
    t.index ["payment_id"], name: "index_payment_orders_on_payment_id"
  end

  create_table "payment_references", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "payment_method_id"
    t.bigint "buyer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_payment_references_on_buyer_id"
    t.index ["payment_method_id"], name: "index_payment_references_on_payment_method_id"
    t.index ["user_id"], name: "index_payment_references_on_user_id"
  end

  create_table "payment_strategies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "strategy"
    t.integer "period", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.decimal "total_amount", precision: 10, scale: 2
    t.decimal "fee_amount", precision: 10, scale: 2
    t.decimal "income_amount", precision: 10, scale: 2
    t.decimal "checked_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "adjust_amount", precision: 10, scale: 2, default: "0.0"
    t.string "payment_uuid"
    t.string "notify_type"
    t.datetime "notified_at"
    t.string "pay_status"
    t.string "sign"
    t.string "seller_identifier"
    t.string "buyer_name"
    t.string "buyer_identifier"
    t.string "buyer_bank"
    t.integer "user_id"
    t.string "currency"
    t.integer "state", default: 0
    t.string "comment"
    t.bigint "payment_method_id"
    t.bigint "creator_id"
    t.boolean "verified", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_payments_on_creator_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "product_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id"
    t.string "qr_code"
    t.string "state"
    t.datetime "produced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "product_parts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_product_parts_on_part_id"
    t.index ["product_id"], name: "index_product_parts_on_product_id"
  end

  create_table "product_plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "state"
    t.integer "planned_count", default: 0
    t.integer "produced_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_plans_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "qr_prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promote_buyers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "buyer_id"
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_promote_buyers_on_buyer_id"
    t.index ["promote_id"], name: "index_promote_buyers_on_promote_id"
  end

  create_table "promote_charges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "promote_id"
    t.decimal "min", precision: 10, scale: 2, default: "0.0"
    t.decimal "max", precision: 10, scale: 2, default: "99999999.99"
    t.decimal "price", precision: 10, scale: 2
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promote_id"], name: "index_promote_charges_on_promote_id"
  end

  create_table "promote_goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "good_type"
    t.bigint "good_id"
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_type", "good_id"], name: "index_promote_goods_on_good_type_and_good_id"
    t.index ["promote_id"], name: "index_promote_goods_on_promote_id"
  end

  create_table "promotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "unit"
    t.string "name"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "scope"
    t.boolean "verified", default: false
    t.boolean "overall", default: false
    t.boolean "contain_max", default: false
    t.integer "sequence", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "area_id"
    t.string "type"
    t.string "name"
    t.string "service_tel"
    t.string "service_qq"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_providers_on_area_id"
  end

  create_table "refunds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "payment_id"
    t.bigint "operator_id"
    t.string "type"
    t.decimal "total_amount", precision: 10, scale: 2
    t.string "buyer_identifier"
    t.string "comment", limit: 512
    t.integer "state", default: 0
    t.datetime "refunded_at"
    t.string "reason", limit: 512
    t.string "currency"
    t.string "refund_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id"], name: "index_refunds_on_operator_id"
    t.index ["order_id"], name: "index_refunds_on_order_id"
    t.index ["payment_id"], name: "index_refunds_on_payment_id"
  end

  create_table "role_rules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "role_id"
    t.integer "rule_id"
    t.integer "govern_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["govern_id"], name: "index_role_rules_on_govern_id"
    t.index ["role_id"], name: "index_role_rules_on_role_id"
    t.index ["rule_id"], name: "index_role_rules_on_rule_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", limit: 1024
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "params"
    t.integer "govern_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["govern_id"], name: "index_rules_on_govern_id"
  end

  create_table "serve_charges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "serve_id"
    t.decimal "min", precision: 10, scale: 2, default: "0.0"
    t.decimal "max", precision: 10, scale: 2, default: "99999999.99"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "base_price", precision: 10, scale: 2, default: "0.0"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serve_id"], name: "index_serve_charges_on_serve_id"
  end

  create_table "serve_goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "good_type"
    t.bigint "good_id"
    t.bigint "serve_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_type", "good_id"], name: "index_serve_goods_on_good_type_and_good_id"
    t.index ["serve_id"], name: "index_serve_goods_on_serve_id"
  end

  create_table "serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "unit"
    t.string "name"
    t.string "scope"
    t.string "extra"
    t.boolean "verified", default: false
    t.boolean "overall", default: true
    t.boolean "contain_max", default: false
    t.boolean "default", default: false
    t.string "deal_type"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_type", "deal_id"], name: "index_serves_on_deal_type_and_deal_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "avatar"
    t.string "email", limit: 100
    t.boolean "email_confirm", default: false
    t.string "mobile", limit: 20
    t.boolean "mobile_confirm", default: false
    t.string "password_digest"
    t.datetime "last_login_at"
    t.string "last_login_ip"
    t.boolean "disabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verify_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", limit: 100
    t.string "token"
    t.datetime "expired_at"
    t.string "account"
    t.integer "access_counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_verify_tokens_on_user_id"
  end

  create_table "who_roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "who_type"
    t.integer "who_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_who_roles_on_role_id"
    t.index ["who_type", "who_id"], name: "index_who_roles_on_who_type_and_who_id"
  end

end
