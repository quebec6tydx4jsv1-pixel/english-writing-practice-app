class FixAiCorrectionsSchema < ActiveRecord::Migration[8.1]
  def change
    remove_column :ai_corrections, :feedback, :text

    add_column :ai_corrections, :score, :integer
    add_column :ai_corrections, :feedback_json, :jsonb
  end
end