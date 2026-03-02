class AiCorrectionsController < ApplicationController
  def create # AI添削の作成アクション
    user_answer = UserAnswer.find(params[:user_answer_id])

    result = mock_correction(user_answer.answer_text)

    ai_correction = user_answer.create_ai_correction!(
      corrected_text: result[:corrected_text],
      feedback: result[:feedback]
    )

    render json: ai_correction
  end

  private

  def mock_correction(answer_text) # AI添削のモック実装
    {
      corrected_text: "Corrected: #{answer_text}",
      feedback: "This is a mock feedback."
    }
  end
end
