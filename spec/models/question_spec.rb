require "rails_helper"

RSpec.describe Question, type: :model do
  describe "関連" do
    it "user_answersを複数持てる" do
      question = create(:question)
      create_list(:user_answer, 2, question: question)
      expect(question.user_answers.count).to eq(2)
    end
  end
end
