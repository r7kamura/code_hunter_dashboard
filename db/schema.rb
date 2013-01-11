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

ActiveRecord::Schema.define(:version => 20130111063924) do

  create_table "warnings", :force => true do |t|
    t.string   "service"
    t.string   "path"
    t.string   "message"
    t.string   "sha1"
    t.string   "author"
    t.string   "email"
    t.datetime "modified_at"
    t.integer  "line"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "warnings", ["modified_at", "author"], :name => "index_warnings_on_modified_at_and_author"
  add_index "warnings", ["modified_at", "created_at", "service"], :name => "index_warnings_on_modified_at_and_created_at_and_service"

end
