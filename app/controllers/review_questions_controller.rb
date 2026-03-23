class ReviewQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_uwe

  def create
    # AI で問題文生成
    question_text = ReviewQuestionGenerationService.call(@uwe)

    # DB 保存
    @review_question = ReviewQuestion.create!(
      user_weak_expression: @uwe,
      question_text: question_text
    )

    # ★ 空の ReviewAnswer を作る（回答前）
    @review_answer = @review_question.review_answers.create!(
      review_answer_text: "",
      user: current_user
    )

    redirect_to user_weak_expression_review_question_path(
      @uwe,
      @review_question,
      @review_answer
    )
  end

  def show
    @review_question = ReviewQuestion.find(params[:id])
    @review_answer = ReviewAnswer.new

    @uwe = @review_question.user_weak_expression # 画面上で苦手表現の内容も表示したいため、@uweもセットしておく
  end

  private

  def set_uwe
    @uwe = current_user.user_weak_expressions.find(params[:user_weak_expression_id])
  end
end
