class QuestionsController < ApplicationController
  def new
  end

  def create
    theme = question_params[:input_theme]
    situation = question_params[:input_situation]

    # AIで問題文生成
    question_text = QuestionGenerationService.call(theme, situation)

    # DB保存
    @question = Question.create!(
      text: question_text,
      input_theme: theme,
      input_situation: situation,
      source: "ai"
    )

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