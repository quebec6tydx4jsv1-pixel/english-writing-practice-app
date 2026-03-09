class MistakeExtractionService
  def self.call(ai_correction)
    new(ai_correction).call
  end

  def initialize(ai_correction)
    @ai_correction = ai_correction
  end

  def call
    mock_extract_mistakes.each do |mistake_data|
      @ai_correction.mistakes.create!(mistake_data)
    end
  end

  private

  def mock_extract_mistakes
    [
      {
        expression_text: "I has",
        category: "grammar",
        reason: "Use 'have' with I"
      }
    ]
  end
end