require "rails_helper"

RSpec.describe ReviewAnswer, type: :model do
  describe "関連" do
    it "review_questionに紐づく" do
      review_answer = build(:review_answer)
      expect(review_answer.review_question).to be_present
    end

    it "userに紐づく" do
      review_answer = build(:review_answer)
      expect(review_answer.user).to be_present
    end
  end

  describe "#answer_text" do
    it "review_answer_textを返す" do
      review_answer = build(:review_answer, review_answer_text: "I went to school.")
      expect(review_answer.answer_text).to eq("I went to school.")
    end
  end

  describe "#question_text" do
    it "review_questionのquestion_textを返す" do
      review_question = create(:review_question, question_text: "昨日何をしましたか？")
      review_answer = create(:review_answer, review_question: review_question)
      expect(review_answer.question_text).to eq("昨日何をしましたか？")
    end
  end
end
