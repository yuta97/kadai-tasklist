module SessionsHelper
  # app/helpers以下に存在するファイルのことをヘルパーモジュールという。
  # ヘルパーモジュール内に記載されたメソッドは、無条件で全てのView内で使用できる。
  def current_user
    # 現在ログインしているUserクラスのインスタンスが返ってくる。
    # ログインしていない場合には、nilが返る。
    # ||=はnilガードと呼ばれている。
    # 左辺がnilならば、右辺を実行し、左辺に代入する。
    # 左辺がnilじゃないならば、そのまま何もしない。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # ログインしているのであればtrueが返り、
    # ログアウト状態ならば、falseが返る。
    # if current_user
    #   return true
    # else
    #   return false
    # end
    !!current_user
  end
end
