class UserWeakExpressionsController < ApplicationController
  before_action :authenticate_user!

  def create
    uwe = current_user.user_weak_expressions.create!(uwe_params)
    render json: uwe
  end

  def index
    uwes = current_user
      .user_weak_expressions
      .includes(:mistake)

    render json: uwes.as_json(
      only: [:id, :note, :created_at],
      include: {
        mistake: {
          only: [:id, :expression_text, :category, :reason]
        }
      }
    )
  end

  def update
    uwe = current_user.user_weak_expressions.find(params[:id])
    uwe.update!(uwe_params)

    render json: uwe
  end

  private

  def uwe_params
    params.permit(:mistake_id, :note)
  end
end