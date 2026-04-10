require "rails_helper"

RSpec.describe UserWeakExpression, type: :model do
  describe "関連" do
    it "userに紐づく" do
      uwe = build(:user_weak_expression)
      expect(uwe.user).to be_present
    end

    it "mistakeに紐づく" do
      uwe = build(:user_weak_expression)
      expect(uwe.mistake).to be_present
    end

    it "review_questionsを複数持てる" do
      uwe = create(:user_weak_expression)
      create_list(:review_question, 2, user_weak_expression: uwe)
      expect(uwe.review_questions.count).to eq(2)
    end
  end

  describe "ユニーク制約" do
    it "同じuserとmistakeの組み合わせは保存できない" do
      user = create(:user)
      mistake = create(:mistake)
      create(:user_weak_expression, user: user, mistake: mistake)
      duplicate = build(:user_weak_expression, user: user, mistake: mistake)
      expect { duplicate.save! }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
