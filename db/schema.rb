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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130622172242) do

  create_table "fields", force: true do |t|
    t.integer  "width"
    t.integer  "height"
    t.integer  "mines"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "locations", force: true do |t|
    t.integer  "field_id"
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.string   "state"
    t.boolean  "has_mine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mines"
  end

end
