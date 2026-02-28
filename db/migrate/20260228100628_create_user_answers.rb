class CreateUserAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :user_answers do |t|
      t.references :user, null: true, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :answer_text

      t.timestamps
    end
  end
end
