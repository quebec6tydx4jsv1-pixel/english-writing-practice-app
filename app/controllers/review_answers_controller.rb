class ReviewAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    review_answer = ReviewAnswer.create!(
      review_question_id: params[:review_question_id],
      user: current_user,
      answer_text: params[:answer_text]
    )

    ai_correction = AiCorrectionService.call(review_answer)

    render json: {
      review_answer: review_answer,
      ai_correction: ai_correction
    }
  end
end