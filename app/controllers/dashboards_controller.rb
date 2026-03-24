class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
      recent_corrections: recent_corrections,
      mistakes_count: mistakes_count,
      review_answers_count: review_answers_count
    }
  end

  private

  def recent_corrections
    current_user
      .ai_corrections
      .includes(user_answer: :question)
      .order(created_at: :desc)
      .limit(5)
      .map do |ac|
        {
          question_text: ac.user_answer.question.text,
          your_answer: ac.user_answer.answer_text,
          corrected_text: ac.corrected_text,
          score: ac.score
        }
      end
  end

  def mistakes_count
    current_user.mistakes.count
  end

  def review_answers_count
    current_user.review_answers.count
  end
end
