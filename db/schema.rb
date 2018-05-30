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

ActiveRecord::Schema.define(version: 20180502140854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "annotated_students", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "annotation_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["annotation_id"], name: "index_annotated_students_on_annotation_id", using: :btree
  end

  create_table "annotations", force: :cascade do |t|
    t.text     "detail"
    t.boolean  "is_additional_subject"
    t.integer  "creator_id"
    t.integer  "category_id"
    t.integer  "group_id"
    t.boolean  "is_group"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "date"
    t.integer  "subject_id"
    t.index ["category_id"], name: "index_annotations_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "default_description"
    t.integer  "severity_id"
    t.integer  "type_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["severity_id"], name: "index_categories_on_severity_id", using: :btree
    t.index ["type_id"], name: "index_categories_on_type_id", using: :btree
  end

  create_table "category_cycles", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "cycle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_category_cycles_on_category_id", using: :btree
    t.index ["cycle_id"], name: "index_category_cycles_on_cycle_id", using: :btree
  end

  create_table "cycle_levels", force: :cascade do |t|
    t.integer  "cycle_id"
    t.integer  "group_level_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["cycle_id"], name: "index_cycle_levels_on_cycle_id", using: :btree
  end

  create_table "cycles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "severities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "has_severity", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_foreign_key "annotated_students", "annotations"
  add_foreign_key "annotations", "categories"
  add_foreign_key "categories", "severities"
  add_foreign_key "categories", "types"
  add_foreign_key "cycle_levels", "cycles"
end
