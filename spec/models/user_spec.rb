require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "メールアドレスとパスワードがあれば有効" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "メールアドレスがなければ無効" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "パスワードがなければ無効" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "パスワードが6文字未満なら無効" do
      user = build(:user, password: "abc")
      expect(user).not_to be_valid
    end

    it "重複するメールアドレスは無効" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end
  end

  describe "関連" do
    it "user_answersを複数持てる" do
      user = create(:user)
      create_list(:user_answer, 3, user: user)
      expect(user.user_answers.count).to eq(3)
    end

    it "user_weak_expressionsを複数持てる" do
      user = create(:user)
      mistake1 = create(:mistake)
      mistake2 = create(:mistake)
      create(:user_weak_expression, user: user, mistake: mistake1)
      create(:user_weak_expression, user: user, mistake: mistake2)
      expect(user.user_weak_expressions.count).to eq(2)
    end
  end

  describe "adminフラグ" do
    it "デフォルトはadminではない" do
      user = create(:user)
      expect(user.admin).to be false
    end

    it "adminトレイトを使うとadminになる" do
      user = create(:user, :admin)
      expect(user.admin).to be true
    end
  end
end
