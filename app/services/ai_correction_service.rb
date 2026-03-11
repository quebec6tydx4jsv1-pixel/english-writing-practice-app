class AiCorrectionService
  def self.call(answer)
    result = mock_correction(answer.answer_text)

    answer.create_ai_correction!(
      corrected_text: result[:corrected_text],
      score: result[:score],
      feedback_json: result[:feedback_json]
    )
  end

  def self.mock_correction(answer_text)
    {
      corrected_text: "Corrected: #{answer_text}",
      score: 100,
      feedback_json: {
        comments: [
          "このフィードバックはモックです"
        ]
      }
    }
  end
end