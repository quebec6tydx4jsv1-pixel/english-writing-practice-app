class QuestionsController < ApplicationController
  include UsageTrackable
  before_action :check_usage_limit, only: [ :create ]

  def new
  end

  def create
    theme = question_params[:input_theme]
    situation = question_params[:input_situation]

    question_text = QuestionGenerationService.call(theme, situation)

    @question = Question.create!(
      text: question_text,
      input_theme: theme,
      input_situation: situation,
      source: "ai"
    )

    increment_usage!
    redirect_to @question
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:input_theme, :input_situation)
  end
end
