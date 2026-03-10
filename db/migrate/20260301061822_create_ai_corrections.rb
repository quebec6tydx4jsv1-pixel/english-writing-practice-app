class CreateAiCorrections < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_corrections do |t|
      t.references :user_answer, null: false, foreign_key: true

      t.text :corrected_text
      t.integer :score
      t.jsonb :feedback_json

      t.timestamps
    end
  end
end