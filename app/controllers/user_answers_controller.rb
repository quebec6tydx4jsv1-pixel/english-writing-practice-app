class UserAnswersController < ApplicationController
  def create
    @user_answer = UserAnswer.create!(user_answer_params)

    AiCorrectionService.call(@user_answer)

    redirect_to user_answer_path(@user_answer)
  end

  def show
    @user_answer = UserAnswer.find(params[:id])

    if user_signed_in?
      load_mistakes
      @user_weak_expression = UserWeakExpression.new
    else
      @mistakes = []
    end
  end

  private

  def load_mistakes
    ai_correction = @user_answer.ai_correction
    return @mistakes = [] unless ai_correction

    # Mistake がまだ生成されていなければ生成する
    if ai_correction.mistakes.empty?
      MistakeExtractionService.call(ai_correction)
      ai_correction.reload # MistakeExtractionService 内で ai_correction.mistakes.create! を呼び出しているため、AI Correctionの関連付けられたMistakeを最新の状態にするためにreloadする必要がある
    end

    @mistakes = ai_correction.mistakes
  end

  def user_answer_params
    params.require(:user_answer).permit(:answer_text, :question_id)
  end
end
