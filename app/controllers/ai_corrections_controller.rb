class AiCorrectionsController < ApplicationController
  def create # AI添削の作成アクション
    user_answer = UserAnswer.find(params[:user_answer_id])

    result = mock_correction(user_answer.answer_text) # 引数のanswer_textがUserの英作文の中身。以下のprivateメソッドの処理結果を格納

    ai_correction = user_answer.create_ai_correction!( #resultからAI添削の内容を取り出して、AI添削をDBに保存
      corrected_text: result[:corrected_text], # 添削された英文 
      feedback: result[:feedback] # 添削コメント。フィードバック
    )

    # render json: ai_correction はレスポンス整形のためコメントアウト。以下のコードで、必要な属性のみをJSON形式で返却
    render json: ai_correction.as_json( # JSON形式でAI添削の内容を返す。as_jsonは、オブジェクトをJSON形式に変換するためのメソッド
      only: [:id, :corrected_text, :feedback, :user_answer_id, :created_at] # ここでは、id、corrected_text、feedback、user_answer_id、created_atの属性のみを含めるように指定
    )
  end

  private

  def mock_correction(answer_text) # AI添削のモック実装
    {
      corrected_text: "Corrected: #{answer_text}",
      feedback: "This is a mock feedback."
    }
  end
end
