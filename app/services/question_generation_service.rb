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

  def generate_question_text
    # モック（後で AI に置き換える）
    "昨日何をしましたか？"
  end
end