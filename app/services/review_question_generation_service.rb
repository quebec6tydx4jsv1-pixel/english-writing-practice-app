class ReviewQuestionGenerationService
  def self.call(user_weak_expression)
    new(user_weak_expression).call
  end

  def initialize(user_weak_expression)
    @uwe = user_weak_expression
  end

  def call
    generate_question_text
  end

  private

  def generate_question_text
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    prompt = <<~PROMPT
      以下の「苦手表現」を必ず使わせる英作文問題の日本語の文章を生成してください。
      
    ▪ 絶対条件
    - 文は、次の苦手表現を含むこと
    - 苦手表現: #{@uwe.mistake.expression_text}
    - 中学生〜社会人が取り組みやすい自然な日本語(1文のみ)
    - 「英訳しなさい」という指示は入れないこと
    
    ■ 補足情報（問題文の内容には使わない）
    - カテゴリ: #{@uwe.mistake.category}
    - 間違えた理由: #{@uwe.mistake.reason}

    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
