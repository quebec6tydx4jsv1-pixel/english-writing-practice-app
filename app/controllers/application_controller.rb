class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :store_return_to

  def after_sign_in_path_for(resource) # 保存したリダイレクト先をセッションから取得し、リダイレクトしつつ削除する。セッションに保存されたリダイレクト先がない場合は、deviseのデフォルトのリダイレクト先を使用
    session.delete(:return_to) || stored_location_for(resource) || root_path
  end

  private

  def store_return_to # before_action で呼び出されるメソッド ログイン後に戻るべき場所をセッションに保存
    session[:return_to] = params[:return_to] if params[:return_to]
  end
end