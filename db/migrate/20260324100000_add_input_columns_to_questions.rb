class AddInputColumnsToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :input_theme, :text unless column_exists?(:questions, :input_theme)
    add_column :questions, :input_situation, :text unless column_exists?(:questions, :input_situation)
  end
end
