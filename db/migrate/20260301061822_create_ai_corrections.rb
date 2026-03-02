class CreateAiCorrections < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_corrections do |t|
      # t.references :user_answer, null: false, foreign_key: true
      t.references :user_answer, null: false, foreign_key: true, index: { unique: true } 
      t.text :corrected_text
      t.text :feedback

      t.timestamps
    end
  end
end
