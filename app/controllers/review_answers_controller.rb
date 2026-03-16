class ReviewAnswersController < ApplicationController
  before_action :authenticate_user!

  def show
    @uwe = current_user.user_weak_expressions.find(params[:user_weak_expression_id])
    @review_question = @uwe.review_question
    @review_answer = @review_question.review_answers.find(params[:id])
  end

  def create
    # 親の WeakExpression を取得
    @uwe = UserWeakExpression.find(params[:user_weak_expression_id])

    # 親の ReviewQuestion を取得（なければ作成）
    @review_question = @uwe.review_question || @uwe.create_review_question!

    # 回答を保存（review_question_id は関連付けで自動セット）
    @review_answer = @review_question.review_answers.create!(
      user: current_user,
      review_answer_text: review_answer_params[:review_answer_text]
    )

    # 添削を実行
    @ai_correction = AiCorrectionService.call(@review_answer)

    # 添削結果画面へ
    redirect_to user_weak_expression_review_question_review_answer_path(@uwe, @review_answer)
  end

  private

  def review_answer_params
    params.require(:review_answer).permit(:review_answer_text)
  end
end
