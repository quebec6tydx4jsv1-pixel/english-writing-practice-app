# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_24_100001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ai_corrections", force: :cascade do |t|
    t.bigint "correctable_id", null: false
    t.string "correctable_type", null: false
    t.text "corrected_text"
    t.datetime "created_at", null: false
    t.jsonb "feedback_json"
    t.integer "score"
    t.datetime "updated_at", null: false
    t.index ["correctable_type", "correctable_id"], name: "index_ai_corrections_on_correctable"
  end

  create_table "mistakes", force: :cascade do |t|
    t.bigint "ai_correction_id", null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.string "expression_text"
    t.text "reason"
    t.datetime "updated_at", null: false
    t.index ["ai_correction_id"], name: "index_mistakes_on_ai_correction_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "input_situation"
    t.text "input_theme"
    t.string "source"
    t.text "text"
    t.datetime "updated_at", null: false
  end

  create_table "review_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "review_answer_text"
    t.bigint "review_question_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["review_question_id"], name: "index_review_answers_on_review_question_id"
    t.index ["user_id"], name: "index_review_answers_on_user_id"
  end

  create_table "review_questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "question_text"
    t.datetime "updated_at", null: false
    t.bigint "user_weak_expression_id", null: false
    t.index ["user_weak_expression_id"], name: "index_review_questions_on_user_weak_expression_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.text "answer_text"
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_weak_expressions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "mistake_id", null: false
    t.text "note"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["mistake_id"], name: "index_user_weak_expressions_on_mistake_id"
    t.index ["user_id", "mistake_id"], name: "index_user_weak_expressions_on_user_id_and_mistake_id", unique: true
    t.index ["user_id"], name: "index_user_weak_expressions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "daily_api_count", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_api_month"
    t.date "last_api_used_on"
    t.integer "monthly_api_count", default: 0, null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mistakes", "ai_corrections"
  add_foreign_key "review_answers", "review_questions"
  add_foreign_key "review_answers", "users"
  add_foreign_key "review_questions", "user_weak_expressions"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_weak_expressions", "mistakes"
  add_foreign_key "user_weak_expressions", "users"
end
