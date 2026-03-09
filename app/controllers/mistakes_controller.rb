class MistakesController < ApplicationController
  def create
    ai_correction = AiCorrection.find(params[:ai_correction_id])

    mistakes = MistakeExtractionService.call(ai_correction)

    render json: mistakes
  end
end