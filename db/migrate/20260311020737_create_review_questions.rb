class CreateReviewQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :review_questions do |t|
      t.references :user_weak_expression, null: false, foreign_key: true
      t.text :question_text

      t.timestamps
    end
  end
end
