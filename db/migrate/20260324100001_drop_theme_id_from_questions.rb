class DropThemeIdFromQuestions < ActiveRecord::Migration[8.1]
  def change
    if column_exists?(:questions, :theme_id)
      remove_column :questions, :theme_id
    end
  end
end
