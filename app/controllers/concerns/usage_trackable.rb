module UsageTrackable
  extend ActiveSupport::Concern

  LIMITS = {
    guest: { daily: 3, monthly: 10 },
    user:  { daily: 5, monthly: 100 }
  }.freeze

  def check_usage_limit
    return if user_signed_in? && current_user.admin?

    if user_signed_in?
      check_registered_user_limit
    else
      check_guest_limit
    end
  end

  def increment_usage!
    return if user_signed_in? && current_user.admin?

    user_signed_in? ? increment_user_usage! : increment_guest_usage!
  end

  private

  # ---- ログインユーザー ----

  def check_registered_user_limit
    reset_user_counters_if_needed!
    limits = LIMITS[:user]
    if current_user.daily_api_count >= limits[:daily]
      redirect_to root_path, alert: "本日の利用回数（#{limits[:daily]}回）に達しました。明日またご利用ください。"
    elsif current_user.monthly_api_count >= limits[:monthly]
      redirect_to root_path, alert: "今月の利用回数（#{limits[:monthly]}回）に達しました。来月またご利用ください。"
    end
  end

  def increment_user_usage!
    reset_user_counters_if_needed!
    current_user.update_columns(
      daily_api_count: current_user.daily_api_count + 1,
      monthly_api_count: current_user.monthly_api_count + 1,
      last_api_used_on: Date.today,
      last_api_month: Date.today.strftime("%Y-%m")
    )
  end

  def reset_user_counters_if_needed!
    today = Date.today
    current_month = today.strftime("%Y-%m")
    updates = {}
    updates[:daily_api_count] = 0 if current_user.last_api_used_on != today
    updates[:monthly_api_count] = 0 if current_user.last_api_month != current_month
    current_user.update_columns(updates) if updates.any?
  end

  # ---- ゲスト ----

  def check_guest_limit
    limits = LIMITS[:guest]
    if guest_daily_count >= limits[:daily]
      redirect_to new_user_registration_path,
        alert: "ゲストの1日の利用上限（#{limits[:daily]}回）に達しました。登録すると1日#{LIMITS[:user][:daily]}回利用できます。"
    elsif guest_monthly_count >= limits[:monthly]
      redirect_to new_user_registration_path,
        alert: "ゲストの今月の利用上限（#{limits[:monthly]}回）に達しました。登録すると月#{LIMITS[:user][:monthly]}回利用できます。"
    end
  end

  def increment_guest_usage!
    today = Date.today.to_s
    current_month = Date.today.strftime("%Y-%m")

    if session["guest_daily_date"] != today
      session["guest_daily_count"] = 0
      session["guest_daily_date"] = today
    end

    if session["guest_monthly_month"] != current_month
      session["guest_monthly_count"] = 0
      session["guest_monthly_month"] = current_month
    end

    session["guest_daily_count"] = session["guest_daily_count"].to_i + 1
    session["guest_monthly_count"] = session["guest_monthly_count"].to_i + 1
  end

  def guest_daily_count
    session["guest_daily_date"] == Date.today.to_s ? session["guest_daily_count"].to_i : 0
  end

  def guest_monthly_count
    session["guest_monthly_month"] == Date.today.strftime("%Y-%m") ? session["guest_monthly_count"].to_i : 0
  end
end
