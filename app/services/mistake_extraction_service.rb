class MistakeExtractionService
  def self.call(ai_correction)
    new(ai_correction).call
  end

  def initialize(ai_correction)
    @ai_correction = ai_correction
  end

  def call
    mistakes = extract_mistakes_with_openai(
      @ai_correction.corrected_text,
      @ai_correction.correctable.answer_text
    )

    created = mistakes.map do |mistake_data|
      @ai_correction.mistakes.create!(mistake_data)
    end

    created
  end

  private

  def extract_mistakes_with_openai(corrected_text, original_text)
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content: <<~PROMPT
              あなたは英作文の誤り抽出の専門家です。
              original_text と corrected_text を比較し、誤りを「抽象化された学習項目」としてJSONで返してください。

              各項目は以下の通りDB に合わせること：
              - expression_text: 学ぶべき短い表現（単語・コロケーション・熟語）、
                                  文法上の誤りの種類（表記： 時制, 大文字, 語法, 語彙）
              - category: 誤りのカテゴリ（例: 文法, 語法, 語彙, タイポ, その他）
              - reason: 日本語で簡潔に説明。必要なら元の誤表現や抽象パターンを短く含める（例: "recently と want の時制不一致; pattern: recently + 過去形"）

              注意：
              - expression_text に誤表現は入れない（正しい表現を入れる）
              - JSON のみ返すこと。誤りごとに1オブジェクト。
            PROMPT
          },
          {
            role: "user",
            content: {
              original_text: original_text,
              corrected_text: corrected_text
            }.to_json
          }
        ],
        response_format: {
          type: "json_schema",
          json_schema: {
            name: "mistakes",
            schema: {
              type: "object",
              properties: {
                mistakes: {
                  type: "array",
                  items: {
                    type: "object",
                    properties: {
                      expression_text: { type: "string" },
                      category: { type: "string" },
                      reason: { type: "string" }
                    },
                    required: [ "expression_text", "category", "reason" ]
                  }
                }
              },
              required: [ "mistakes" ]
            }
          }
        }
      }
    )

    JSON.parse(response.dig("choices", 0, "message", "content"), symbolize_names: true)[:mistakes]
  end
end
