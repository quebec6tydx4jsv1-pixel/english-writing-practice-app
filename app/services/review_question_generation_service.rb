class ReviewQuestionGenerationService
  def self.call(user_weak_expression)
    new(user_weak_expression).call
  end

  def initialize(user_weak_expression)
    @uwe = user_weak_expression
  end

  def call
    ReviewQuestion.create!(
      user_weak_expression: @uwe,
      question_text: generate_question_text,
      generated_at: Time.current
    )
  end

  private

  def generate_question_text
    # モック版（後でAIに差し替え）
    "次の表現を使って英作文してください: #{@uwe.expression_text}"
  end
end