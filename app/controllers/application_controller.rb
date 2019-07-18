class ApplicationController < ActionController::Base

  # include モジュールとすることで、モジュール内に記載された全てのメソッドが、
  # 当該クラスのインスタンスメソッドとして定義される。
  # これをMix-inという。
  # ApplicationControllerは、（原則として）全てのControllerが継承している。
  # 従って、全てのControllerの中でSessionsHelperのメソッドがインスタンスメソッドとして使える。
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
