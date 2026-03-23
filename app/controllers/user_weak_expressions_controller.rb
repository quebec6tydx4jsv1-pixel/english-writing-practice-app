class UserWeakExpressionsController < ApplicationController
  before_action :authenticate_user!

  def create
    mistake_ids = params[:user_weak_expression][:mistake_ids].to_s.split(",")

    mistake_ids.each do |mistake_id|
      current_user.user_weak_expressions.create!(
        mistake_id: mistake_id,
        note: params[:user_weak_expression][:note]
      )
    end

    redirect_to user_weak_expressions_path
  end

  def index
    @user_weak_expressions = current_user
      .user_weak_expressions
      .includes(:mistake)
  end

  def edit
    @user_weak_expression = current_user.user_weak_expressions.find(params[:id])
  end

  def update
    @user_weak_expression = current_user.user_weak_expressions.find(params[:id])
    @user_weak_expression.update!(uwe_params)
    redirect_to user_weak_expressions_path
  end

  def destroy
    @user_weak_expression = current_user.user_weak_expressions.find(params[:id])
    @user_weak_expression.destroy!
    redirect_to user_weak_expressions_path, notice: "削除しました"
  end

  private

  def uwe_params
    params.require(:user_weak_expression).permit(:mistake_ids, :note)
  end
end
