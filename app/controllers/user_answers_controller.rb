class UserAnswersController < ApplicationController
  def show
    @user_answer = UserAnswer.find(params[:id])
  end
end
