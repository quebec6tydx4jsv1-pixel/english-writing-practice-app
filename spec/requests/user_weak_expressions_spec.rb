require "rails_helper"

RSpec.describe "UserWeakExpressions", type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET /user_weak_expressions" do
    it "200を返す" do
      get user_weak_expressions_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /user_weak_expressions" do
    it "作成後にindexへリダイレクトする" do
      mistake = create(:mistake)
      post user_weak_expressions_path, params: {
        user_weak_expression: { mistake_ids: mistake.id.to_s, note: "" }
      }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_weak_expressions_path)
    end
  end

  describe "PATCH /user_weak_expressions/:id" do
    it "更新後にindexへリダイレクトする" do
      uwe = create(:user_weak_expression, user: user)
      patch user_weak_expression_path(uwe), params: {
        user_weak_expression: { note: "更新メモ" }
      }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_weak_expressions_path)
    end
  end

  describe "DELETE /user_weak_expressions/:id" do
    it "削除後にindexへリダイレクトする" do
      uwe = create(:user_weak_expression, user: user)
      delete user_weak_expression_path(uwe)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_weak_expressions_path)
    end
  end

  describe "未ログイン時" do
    before { sign_out user }

    it "indexはログインページへリダイレクトする" do
      get user_weak_expressions_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
