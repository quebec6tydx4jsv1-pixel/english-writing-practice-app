class ReviewAnswersController < ApplicationController
  before_action :authenticate_user!

  def show
    @review_answer = ReviewAnswer.find(params[:id])
    @review_question = @review_answer.review_question
    @uwe = @review_question.user_weak_expression
  end

  def create
    # 1. 既存の ReviewAnswer を取得（URL の :id を使う）
    @review_answer = ReviewAnswer.find(params[:id])

    # 2. 関連を辿る（show と同じ）
    @review_question = @review_answer.review_question
    @uwe = @review_question.user_weak_expression

    # 3. 回答内容を更新
    @review_answer.update!(
      review_answer_text: review_answer_params[:review_answer_text]
    )

    # 4. 添削を実行
    AiCorrectionService.call(@review_answer)

    # 5. 添削結果画面へ
    redirect_to user_weak_expression_review_question_review_answer_path(
      @uwe,
      @review_question,
      @review_answer
    )
  end

  private

  def review_answer_params
    params.require(:review_answer).permit(:review_answer_text)
  end
end
