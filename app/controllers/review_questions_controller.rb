class ReviewQuestionsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @uwe = current_user.user_weak_expressions.find(params[:user_weak_expression_id])

    @review_question =
      @uwe.review_question ||
      ReviewQuestionGenerationService.call(@uwe)

    @review_answer = ReviewAnswer.new
  end
end
