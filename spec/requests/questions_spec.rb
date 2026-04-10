require "rails_helper"

RSpec.describe "Questions", type: :request do
  describe "GET /questions/new" do
    it "200を返す" do
      get new_question_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /questions/:id" do
    it "200を返す" do
      question = create(:question)
      get question_path(question)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /questions" do
    before do
      allow(QuestionGenerationService).to receive(:call).and_return("昨日何をしましたか？")
    end

    context "ゲストユーザーの場合" do
      it "作成後にquestion showへリダイレクトする" do
        post questions_path, params: { question: { input_theme: "旅行", input_situation: "友達と海外旅行した" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(question_path(Question.last))
      end
    end

    context "ログインユーザーの場合" do
      let(:user) { create(:user) }
      before { sign_in user }

      it "作成後にquestion showへリダイレクトする" do
        post questions_path, params: { question: { input_theme: "旅行", input_situation: "友達と海外旅行した" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(question_path(Question.last))
      end
    end
  end
end
