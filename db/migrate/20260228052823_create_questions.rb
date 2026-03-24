class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.text :input_theme # テーマ
      t.text :input_situation # テーマの状況
      t.text :text # 問題文(日本語)
      t.string :source

      t.timestamps
    end
  end
end
