class QuestionGenerationService
  def self.call(theme, situation)
    new(theme, situation).call
  end

  def initialize(theme, situation)
    @theme = theme
    @situation = situation
  end

  def call
    # ここで AI API を叩く（仮実装）
    # 実際は OpenAI / Azure OpenAI などを呼ぶ
    generate_question_text
  end

  private

  # def generate_question_text
    # モック（後で AI に置き換える）
    #"昨日何をしましたか？"
  #end

  def generate_question_text
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    prompt = <<~PROMPT
      以下のテーマと状況に基づいて、英作文練習用の日本語文を1つ生成してください。

      テーマ: #{@theme}
      状況: #{@situation}

      条件:
      - 中学生〜社会人が練習しやすい自然な日本語文
      - 1文のみ
      - 40〜80文字程度
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )

    response.dig("choices", 0, "message", "content")
  end

end