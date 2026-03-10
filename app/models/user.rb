class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :user_answers, dependent: :destroy # 英作文の回答 
  has_many :ai_corrections, through: :user_answers # AIによる添削
  has_many :mistakes, through: :ai_corrections # AIによる添削で指摘された誤り
  has_many :user_weak_expressions, dependent: :destroy # ユーザーの弱点表現
  has_many :review_answers, dependent: :destroy # 復習用の回答
end