class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :theme, null: false, foreign_key: true
      t.text :text
      t.string :source

      t.timestamps
    end
  end
end
