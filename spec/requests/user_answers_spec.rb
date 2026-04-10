require "rails_helper"

RSpec.describe "UserAnswers", type: :request do
  describe "GET /user_answers/:id" do
    it "200を返す" do
      user_answer = create(:user_answer)
      get user_answer_path(user_answer)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /user_answers" do
    before do
      allow(AiCorrectionService).to receive(:call)
    end

    context "ゲストユーザーの場合" do
      it "作成後にuser_answer showへリダイレクトする" do
        question = create(:question)
        post user_answers_path, params: { user_answer: { answer_text: "I went to school.", question_id: question.id } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_answer_path(UserAnswer.last))
      end
    end
  end
end
