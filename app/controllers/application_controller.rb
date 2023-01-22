class ApplicationController < ActionController::Base
  before_action :set_locale
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
# パラメーターの説明
# /articles/1 => params[:id]
# /articles?id=1 => params[:id]
# /articles?user_status=now => params[:user_stauts] 
# という形で各々取得できる。これはrailsのルール 
# ?を書いてパラメーターをつける時はroutesに書かなくても自由に設定できる。　気軽にパラメーターを追加したいときは使う。
# 一般的にはトラッキングコードに使われたりする。マーケティングのツールでどこからアクセスしたのか。キャンペーンでツイッター広告から流入しました
# というケースで使う。 ?imporession=twitter
