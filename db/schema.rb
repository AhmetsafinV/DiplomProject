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

ActiveRecord::Schema.define(version: 20160528161910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.text     "name"
    t.date     "started_date"
    t.date     "finished_date"
    t.integer  "period"
    t.integer  "wday"
    t.text     "room_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "human_htype"
    t.integer  "started_time"
    t.integer  "finished_time"
  end

  create_table "courses_groups", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "group_id"
  end

  add_index "courses_groups", ["course_id"], name: "index_courses_groups_on_course_id", using: :btree
  add_index "courses_groups", ["group_id"], name: "index_courses_groups_on_group_id", using: :btree

  create_table "courses_tutors", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "tutor_id"
  end

  add_index "courses_tutors", ["course_id"], name: "index_courses_tutors_on_course_id", using: :btree
  add_index "courses_tutors", ["tutor_id"], name: "index_courses_tutors_on_tutor_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "course_id"
    t.text     "typeL"
    t.text     "typeA"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  create_table "results", force: :cascade do |t|
    t.boolean  "attendance"
    t.integer  "mark"
    t.integer  "student_id"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.text     "first_name"
    t.text     "second_name"
    t.text     "last_name"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.text     "first_name"
    t.text     "second_name"
    t.text     "last_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
