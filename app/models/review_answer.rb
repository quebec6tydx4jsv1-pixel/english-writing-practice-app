class ReviewAnswer < ApplicationRecord
  belongs_to :review_question
  belongs_to :user

  has_one :ai_correction, as: :correctable, dependent: :destroy

  # AiCorrectionService が answer_text を呼んでも動くようにする
  def answer_text
    review_answer_text
  end
  
  def question_text
    review_question.question_text
  end
end
