class CreateReviewAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :review_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review_question, null: false, foreign_key: true
      t.text :review_answer_text

      t.timestamps
    end
  end
end
