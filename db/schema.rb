# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110608183620) do

  create_table "allowed_bats", :force => true do |t|
    t.integer  "protocol_id"
    t.integer  "species_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warning_limit", :default => 0
  end

  create_table "bat_changes", :force => true do |t|
    t.integer  "bat_id",               :null => false
    t.date     "date",                 :null => false
    t.integer  "user_id"
    t.integer  "new_cage_id"
    t.integer  "old_cage_id"
    t.integer  "owner_old_id"
    t.integer  "owner_new_id"
    t.integer  "cage_in_history_id"
    t.integer  "medical_treatment_id"
    t.text     "note"
    t.string   "old_band_name"
    t.string   "new_band_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "surgery_id"
    t.integer  "protocol_history_id"
  end

  create_table "bat_notes", :force => true do |t|
    t.integer  "bat_id",  :null => false
    t.datetime "date",    :null => false
    t.text     "text",    :null => false
    t.integer  "user_id", :null => false
  end

  create_table "bats", :force => true do |t|
    t.integer "cage_id"
    t.date    "collection_date"
    t.string  "collection_age",      :limit => 45,                    :null => false
    t.string  "collection_place",    :limit => 100,                   :null => false
    t.string  "gender",              :limit => 1,                     :null => false
    t.date    "leave_date"
    t.text    "leave_reason"
    t.string  "band",                :limit => 10
    t.date    "vaccination_date"
    t.integer "species_id"
    t.boolean "monitor_weight",                     :default => true, :null => false
    t.boolean "monitor_vaccination",                :default => true
  end

  create_table "bats_protocols", :id => false, :force => true do |t|
    t.integer "bat_id"
    t.integer "protocol_id"
  end

  create_table "cage_in_histories", :force => true do |t|
    t.integer  "bat_id",  :null => false
    t.integer  "cage_id", :null => false
    t.datetime "date"
    t.integer  "user_id"
    t.text     "note"
  end

  create_table "cage_out_histories", :force => true do |t|
    t.integer  "bat_id",             :null => false
    t.integer  "cage_id",            :null => false
    t.datetime "date"
    t.integer  "user_id"
    t.text     "note"
    t.integer  "cage_in_history_id"
  end

  create_table "cages", :force => true do |t|
    t.string  "name",           :limit => 45,                    :null => false
    t.date    "date_created"
    t.date    "date_destroyed"
    t.integer "user_id"
    t.integer "room_id",                                         :null => false
    t.boolean "flight_cage",                  :default => false, :null => false
  end

  create_table "census", :force => true do |t|
    t.integer "animals"
    t.date    "date",                         :null => false
    t.integer "room_id",                      :null => false
    t.string  "bats_added",   :limit => 2000
    t.string  "bats_removed", :limit => 2000
  end

  create_table "data", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_protocols", :id => false, :force => true do |t|
    t.integer "datum_id",    :null => false
    t.integer "protocol_id", :null => false
  end

  create_table "flights", :force => true do |t|
    t.integer "bat_id",                                :null => false
    t.date    "date"
    t.integer "user_id",                               :null => false
    t.text    "note"
    t.boolean "exempt"
    t.integer "medical_problem_id"
    t.integer "cage_id"
    t.integer "species_id"
    t.boolean "quarantine"
    t.boolean "has_surgery",        :default => false
  end

  create_table "flights_surgeries", :id => false, :force => true do |t|
    t.integer "surgery_id"
    t.integer "flight_id"
  end

  create_table "medical_problems", :force => true do |t|
    t.integer  "bat_id",                      :null => false
    t.datetime "date_opened",                 :null => false
    t.text     "description",                 :null => false
    t.date     "date_closed"
    t.string   "title",         :limit => 45, :null => false
    t.string   "reason_closed", :limit => 45
  end

  create_table "medical_treatments", :force => true do |t|
    t.string  "title",              :limit => 45, :null => false
    t.integer "medical_problem_id"
    t.date    "date_opened",                      :null => false
    t.date    "date_closed"
  end

  create_table "protocol_histories", :force => true do |t|
    t.integer  "bat_id"
    t.integer  "protocol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
    t.boolean  "added"
    t.integer  "user_id"
  end

  create_table "protocols", :force => true do |t|
    t.string   "title"
    t.string   "number"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
  end

  create_table "protocols_surgeries", :id => false, :force => true do |t|
    t.integer "surgery_id"
    t.integer "protocol_id"
  end

  create_table "protocols_surgery_types", :id => false, :force => true do |t|
    t.integer "surgery_type_id"
    t.integer "protocol_id"
  end

  create_table "protocols_users", :id => false, :force => true do |t|
    t.integer  "protocol_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string "name", :limit => 45, :null => false
  end

  create_table "species", :force => true do |t|
    t.string  "name",                    :limit => 45,                    :null => false
    t.float   "lower_weight_limit",                                       :null => false
    t.float   "upper_weight_limit",                                       :null => false
    t.integer "hibernating_start_month"
    t.integer "hibernating_end_month"
    t.boolean "requires_vaccination",                  :default => false
  end

  create_table "surgeries", :force => true do |t|
    t.integer  "surgery_type_id"
    t.integer  "bat_id"
    t.datetime "time"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_census", :force => true do |t|
    t.date    "date",                               :null => false
    t.string  "internal_description", :limit => 45, :null => false
    t.date    "date_done"
    t.integer "room_id",                            :null => false
    t.integer "task_id",                            :null => false
  end

  create_table "task_histories", :force => true do |t|
    t.integer  "task_id",   :null => false
    t.datetime "date_done", :null => false
    t.text     "remarks",   :null => false
    t.integer  "user_id",   :null => false
    t.float    "fed"
    t.integer  "weight_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "repeat_code"
    t.integer  "medical_treatment_id"
    t.integer  "cage_id"
    t.text     "title",                              :null => false
    t.text     "notes",                              :null => false
    t.string   "internal_description", :limit => 45
    t.float    "food"
    t.string   "dish_type",            :limit => 45
    t.integer  "dish_num"
    t.integer  "jitter",                             :null => false
    t.datetime "date_started",                       :null => false
    t.datetime "date_ended"
    t.boolean  "animal_care"
    t.integer  "room_id"
  end

  create_table "tasks_users", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "task_id", :null => false
  end

  create_table "training_types", :force => true do |t|
    t.string "name",        :null => false
    t.text   "description"
  end

  create_table "trainings", :force => true do |t|
    t.integer "training_type_id",   :null => false
    t.integer "user_id",            :null => false
    t.date    "date",               :null => false
    t.integer "user_trained_by_id", :null => false
    t.text    "note"
  end

  create_table "users", :force => true do |t|
    t.string "name",       :limit => 100, :null => false
    t.string "initials",   :limit => 45,  :null => false
    t.string "email",      :limit => 100
    t.date   "start_date"
    t.date   "end_date"
    t.string "job_type",   :limit => 100
  end

  create_table "weathers", :force => true do |t|
    t.date    "log_date",                  :null => false
    t.float   "temperature",               :null => false
    t.float   "humidity",                  :null => false
    t.integer "room_id",                   :null => false
    t.string  "sig",         :limit => 45, :null => false
  end

  create_table "weights", :force => true do |t|
    t.integer  "bat_id",                    :null => false
    t.datetime "date",                      :null => false
    t.float    "weight",                    :null => false
    t.text     "note",                      :null => false
    t.string   "after_eating", :limit => 1, :null => false
    t.integer  "user_id",                   :null => false
  end

end
