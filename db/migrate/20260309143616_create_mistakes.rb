class CreateMistakes < ActiveRecord::Migration[8.1]
  def change
    create_table :mistakes do |t|
      t.references :ai_correction, null: false, foreign_key: true

      t.string :expression_text
      t.string :category
      t.text :reason

      t.timestamps
    end
  end
end