class ReviewQuestionsController < ApplicationController
  include UsageTrackable
  before_action :authenticate_user!
  before_action :set_uwe
  before_action :check_usage_limit, only: [:create]

  def create
    question_text = ReviewQuestionGenerationService.call(@uwe)

    @review_question = ReviewQuestion.create!(
      user_weak_expression: @uwe,
      question_text: question_text
    )

    @review_answer = @review_question.review_answers.create!(
      review_answer_text: "",
      user: current_user
    )

    increment_usage!
    redirect_to user_weak_expression_review_question_path(
      @uwe,
      @review_question
    )
  end

  def show
    @review_question = ReviewQuestion.find(params[:id])
    @uwe = @review_question.user_weak_expression # 画面上で苦手表現の内容も表示したいため、@uweもセットしておく
    # @review_answer = ReviewAnswer.new
    @review_answer = @review_question.review_answers.first
  end

  private

  def set_uwe
    @uwe = current_user.user_weak_expressions.find(params[:user_weak_expression_id])
  end
end
