class CreateUserWeakExpressions < ActiveRecord::Migration[8.1]
  def change
    create_table :user_weak_expressions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mistake, null: false, foreign_key: true

      t.text :note

      t.timestamps
    end

    add_index :user_weak_expressions, [:user_id, :mistake_id], unique: true
  end
end