class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_weak_expressions, dependent: :destroy # ユーザーの弱点表現
  has_many :user_answers, dependent: :destroy # ユーザーの回答
end
