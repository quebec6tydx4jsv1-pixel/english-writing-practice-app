class AiCorrectionService
  def self.call(answer)
    result = correct_with_openai(answer)

    answer.create_ai_correction!(
      corrected_text: result[:corrected_text],
      score: result[:score],
      feedback_json: result[:feedback_json]
    )
  end

  def self.correct_with_openai(answer)
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    japanese_question = answer.question_text
    user_english      = answer.answer_text

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content: <<~SYS
              あなたは英作文の添削を行う英語教師です。
              問題文（日本語）の意味を考えつつ添削し、かつ英文の文法・語彙・自然さを評価し、
              修正文を作成し、スコア(10点満点)を出力しなさい。
              日本人が読むため、添削コメントは必ず日本語で（英語不可)。
            SYS
          },
          {
            role: "user",
            content: <<~MSG
              【問題文（日本語）】
              #{japanese_question}

              【ユーザーの英文】
              #{user_english}
            MSG
          }
        ],
        response_format: {
          type: "json_schema",
          json_schema: {
            name: "correction",
            schema: {
              type: "object",
              properties: {
                corrected_text: { type: "string" },
                score:          { type: "integer" },
                feedback_json:  {
                  type: "object",
                  properties: {
                    comments: { type: "array", items: { type: "string" } }
                  }
                }
              },
              required: ["corrected_text", "score", "feedback_json"]
            }
          }
        }
      }
    )

    JSON.parse(response.dig("choices", 0, "message", "content"), symbolize_names: true)
  end
end
