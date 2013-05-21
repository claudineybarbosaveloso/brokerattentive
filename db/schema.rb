# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130306164627) do

  create_table "consolidates", :force => true do |t|
    t.integer  "user_id",                                             :null => false
    t.string   "name"
    t.integer  "registration",                                        :null => false
    t.integer  "series",                                              :null => false
    t.integer  "proposal",                                            :null => false
    t.string   "code_beneficiary",                                    :null => false
    t.integer  "plan",                                                :null => false
    t.integer  "number_quota",                                        :null => false
    t.decimal  "value_contribution",    :precision => 8, :scale => 2
    t.decimal  "commission_percentage", :precision => 8, :scale => 2
    t.decimal  "commission_value",      :precision => 8, :scale => 2
    t.datetime "period_initial",                                      :null => false
    t.datetime "period_final",                                        :null => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "consolidates", ["user_id"], :name => "index_consolidates_on_user_id"

  create_table "credits_logs", :force => true do |t|
    t.integer  "previous_credits"
    t.integer  "new_credits"
    t.integer  "user_id"
    t.integer  "previous_plan_id"
    t.integer  "new_plan_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "extract_monthlies", :force => true do |t|
    t.integer  "user_id",                                             :null => false
    t.string   "name"
    t.integer  "registration",                                        :null => false
    t.integer  "series",                                              :null => false
    t.integer  "proposal",                                            :null => false
    t.string   "code_beneficiary",                                    :null => false
    t.integer  "plan",                                                :null => false
    t.integer  "number_quota",                                        :null => false
    t.decimal  "value_contribution",    :precision => 8, :scale => 2
    t.decimal  "commission_percentage", :precision => 8, :scale => 2
    t.decimal  "commission_value",      :precision => 8, :scale => 2
    t.datetime "period_initial",                                      :null => false
    t.datetime "perido_final",                                        :null => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "extract_monthlies", ["user_id"], :name => "index_extract_monthlies_on_user_id"

  create_table "extract_weeklies", :force => true do |t|
    t.integer  "user_id",                                             :null => false
    t.string   "name"
    t.integer  "registration",                                        :null => false
    t.integer  "series",                                              :null => false
    t.integer  "proposal",                                            :null => false
    t.string   "code_beneficiary",                                    :null => false
    t.integer  "plan",                                                :null => false
    t.integer  "number_quota",                                        :null => false
    t.decimal  "value_contribution",    :precision => 8, :scale => 2
    t.decimal  "commission_percentage", :precision => 8, :scale => 2
    t.decimal  "commission_value",      :precision => 8, :scale => 2
    t.datetime "period_initial",                                      :null => false
    t.datetime "period_final",                                        :null => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "extract_weeklies", ["user_id"], :name => "index_extract_weeklies_on_user_id"

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.integer  "maximum_customers"
    t.decimal  "price",             :precision => 10, :scale => 0
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.string   "status"
    t.boolean  "administrator"
    t.integer  "credits",                :default => 0
    t.integer  "plan_id"
    t.integer  "previous_plan_id"
    t.boolean  "terms_of_service",       :default => false
    t.integer  "cpf_cnpj"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
